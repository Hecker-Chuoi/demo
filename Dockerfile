FROM maven:3.9.9-amazoncorretto-23 AS build
# Dùng container có chứa maven và jdk 23 để complie, build và đóng gói project dưới dạng file jar

WORKDIR /app
COPY pom.xml .
COPY src ./src

RUN mvn package
# Tạo file jar thành công

FROM amazoncorretto:23
# Cần jdk 23 để chạy file jar

WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]