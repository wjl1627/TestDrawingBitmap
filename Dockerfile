FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-1803 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.1-sdk-nanoserver-1803 AS build
WORKDIR /src
COPY ["DrawingBitmapMVC/DrawingBitmapMVC.csproj", "DrawingBitmapMVC/"]
RUN dotnet restore "DrawingBitmapMVC/DrawingBitmapMVC.csproj"
COPY . .
WORKDIR "/src/DrawingBitmapMVC"
RUN dotnet build "DrawingBitmapMVC.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "DrawingBitmapMVC.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "DrawingBitmapMVC.dll"]