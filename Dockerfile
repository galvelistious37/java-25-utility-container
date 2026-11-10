# JDK 25 + Maven utility image. Source code is bind-mounted at /workspace.
FROM maven:3-eclipse-temurin-25

WORKDIR /workspace

CMD ["bash"]
