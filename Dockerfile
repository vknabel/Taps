FROM kylef/swiftenv

RUN mkdir -p /code
WORKDIR /code
ADD . /code

RUN swiftenv install
RUN bundle install
RUN swift fetch
