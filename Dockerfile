FROM kylef/swiftenv:swift3

RUN mkdir -p /code
WORKDIR /code
ADD ./Sources /code/Sources
ADD ./Tests /code/Tests
ADD ./Package.swift /code/Package.swift
