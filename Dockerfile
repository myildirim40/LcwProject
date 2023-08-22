FROM mcr.microsoft.com/dotnet/sdk:3.1-buster as build-env
WORKDIR /src
COPY Lcw.Kubernetes.Test/*.csproj .
RUN dotnet restore
COPY Lcw.Kubernetes.Test .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1-buster-slim as runtime
WORKDIR /publish
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "Lcw.Kubernetes.Test.App.dll"]
