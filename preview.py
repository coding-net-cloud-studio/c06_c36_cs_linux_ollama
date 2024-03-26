#!/usr/bin/env python

from flask import Flask, render_template_string
import markdown

app = Flask(__name__)

@app.route('/')
def home():
    with open('README.md', 'r') as markdown_file:
        content = markdown_file.read()
        html_content = markdown.markdown(content)
        return render_template_string('''
            <html>
                <head>
                    <style>
                        img {{
                            max-width: 100%;
                            width: auto;
                            height: auto;
                        }}
                    </style>
                </head>
                <body>
                    {}
                </body>
            </html>
        '''.format(html_content))

if __name__ == '__main__':
    app.run(debug=True)