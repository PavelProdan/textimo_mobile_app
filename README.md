<img width="400" alt="textimo-banner2" style="text-align:center;" src="https://user-images.githubusercontent.com/35011979/184703095-db4217f5-56f1-4dc3-97af-8457abaac6f7.png">


![NodeJS](https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white)

![Raspberry Pi](https://img.shields.io/badge/-RaspberryPi-C51A4A?style=for-the-badge&logo=Raspberry-Pi)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

# About Textimo

Textimo is a software solution designed to stream live lyrics to a video projector without a laptop, by simply connecting a Raspberry Pi to the video projector. The Raspberry is configured to be plug and play: you just have to power up the Raspberry and connect the HDMI cable to the video projector. Then you have to connect the mobile app to Raspberry's WiFi hotspot and stream or add lyrics.

From the Textimo Mobile App, you can control and customize the live stream: what song's verse to show or how the Live Page should look (background color, font size, etc.)

## Short Demo
https://user-images.githubusercontent.com/35011979/204353532-cc59342e-797e-4b2f-8d14-902e7ce11ab6.mp4

## How it works

<img width="1503" alt="textimo diagram" src="https://user-images.githubusercontent.com/35011979/204353994-6296e792-e9db-4041-861f-9c23d263af41.png">

Textimo uses two services:

- **Textimo Backend Server:**  it's a NodeJS App that runs in the background on the Raspberry Pi and a Full Screen Sandbox Chromium Window that is displayed on the external screen via HDMI (projector or display) on startup. Raspberry Pi runs the light versions (without desktop) edition of Raspbian (Stretch), and uses Xorg display manager to display only the Chromium window. 

- **Textimo Mobile App:** a Flutter app that uses Textimo Server REST API to control everything. The app connects to the Raspberry PI using the WiFi hotspot created by the Raspberry itself. 
