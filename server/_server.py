from flask import Flask, redirect, request
import pickle, string, nltk 
from nltk.corpus import stopwords
import json
# from nltk.stem.porter import PorterStemmer
# ps = PorterStemmer()

tfidf = pickle.load(open('server/vectorizer.pkl', 'rb'))
model = pickle.load(open('server/model.pkl', 'rb'))

def transform_text(text):
    text = text.lower()
    text = nltk.word_tokenize(text)

    y = []
    for i in text:
        if i.isalnum():
            y.append(i)
            
    text = y[:]
    y.clear()

    for i in text:
        if i not in stopwords.words('english') and i not in string.punctuation:
            y.append(i)
    
    # text = y[:]
    # y.clear()

    # for i in text:
    #     y.append(ps.stem(i))

    return ' '.join(y)


app = Flask(__name__)

@app.route('/')
def welcome():
    return 'Server is running!'

@app.route('/predict/<string:sms_sent>', methods = ['POST', 'GET'])
def predict(sms_sent):
    if request.method == 'POST':
        transformed_sms = transform_text(sms_sent)
        vector_input = tfidf.transform([transformed_sms])
        result = model.predict(vector_input)[0]
        if(result==1):
            return 'Spam!', {"Access-Control-Allow-Origin": "*", "Access-Control-Allow_Methods": "GET, POST"}
        else:
            return 'Not Spam!', {"Access-Control-Allow-Origin": "*", "Access-Control-Allow_Methods": "GET, POST"}
        
    if request.method == 'GET':
        transformed_sms = transform_text(sms_sent)
        vector_input = tfidf.transform([transformed_sms])
        result = model.predict(vector_input)[0]
        if(result==1):
            return 'Spam!', {"Access-Control-Allow-Origin": "*", "Access-Control-Allow_Methods": "GET, POST"}
        else:
            return 'Not Spam!', {"Access-Control-Allow-Origin": "*", "Access-Control-Allow_Methods": "GET, POST"}
        
@app.route('/predict/', methods = ['GET'])
def returnNull():
    if request.method == 'GET':
        return '', {"Access-Control-Allow-Origin": "*", "Access-Control-Allow_Methods": "GET, POST"}

if __name__ == "__main__":
    app.run(debug=True, port = 33)


# @app.route('/predict/<string:sms_sent>', methods = ['POST', 'GET])
# def predict(sms_sent):
#  if request.method == 'GET':

# resp = Flask.make_response('{"Prediction": "Spam"}')
# resp.headers['Access-Control-Allow-Origin'] = '*'
# resp.headers['Access-Control-Allow_Methods']: 'GET, POST'
# return resp 
        