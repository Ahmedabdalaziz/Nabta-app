

## Overview
Nabta is a mobile application developed to assist farmers, veterinarians, and anyone interested in agriculture. The app provides several features that aim to improve farming practices, livestock health, and crop management. These features include plant disease detection using AI, veterinary reporting for sick animals, educational content on plants, animals, and chemicals, as well as daily weather forecasts for the local area. Additionally, the app offers a specialized AI chatbot, **Nabta AI**, to assist users with their queries and tasks.

---

## Features

### 1. **Plant Disease Detection**
The app uses **AI-based technology** to detect diseases in plants by analyzing images. Users can simply upload a picture of a plant, and the AI model will diagnose any diseases, providing possible solutions or treatment recommendations.

### 2. **Veterinary Reporting**
Farmers and veterinarians can report sick animals. The app allows users to log symptoms, which can then be analyzed by the system to provide veterinary advice or alert a professional for further help.

### 3. **Educational Content**
The app contains detailed information about:
- **Plants**: Types, care instructions, and common diseases.
- **Animals**: Information about livestock, diseases, and general care.
- **Chemicals**: Details on the safe usage of agricultural chemicals and pesticides.

### 4. **Learning Videos**
The app offers a selection of educational **video content** for farmers, veterinarians, and agricultural enthusiasts. These videos cover best practices for farming, animal care, plant health, and more.

### 5. **Agricultural News**
Stay updated with the latest agricultural news. The app features a **daily agricultural bulletin** with relevant news articles, trends, and updates in the world of farming.

### 6. **Weather Forecast (3-Day)**
Users can get the weather forecast for their current location. The app provides a 3-day weather outlook, helping farmers plan their tasks according to the weather conditions.

### 7. **Nabta AI Chatbot**
A special AI chatbot named **Nabta AI** assists users by answering queries related to agriculture. Whether it's about plant diseases, animal health, or farming tips, **Nabta AI** is always available to help.

---

## Security Features

- **Secure Authentication**: The app uses token-based authentication to ensure secure login. Tokens are encrypted and stored securely to protect user data.
- **Data Encryption**: All sensitive information, including personal data, passwords, and authentication tokens, is encrypted to prevent unauthorized access.
- **Backend Integration**: The app is integrated with a **Node.js backend** that handles user requests, data processing, and API calls, ensuring smooth communication between the frontend and backend.

---

## Technical Architecture

- **Frontend**: Flutter-based mobile application for iOS and Android.
- **Backend**: Node.js server that handles requests, API integrations, and AI model processing.
- **AI Model**: A pre-trained deep learning model for plant disease detection.
- **Security**: 
  - Tokens and sensitive data are encrypted using industry-standard encryption algorithms.
  - Secure communication through HTTPS.
  - JWT (JSON Web Tokens) for secure authentication.

---

## Installation

### Prerequisites
- Flutter SDK (for mobile app development)
- Node.js (for backend development)

### Steps to Run the App

1. **Clone the Repository**
   ```
   git clone https://github.com/Ahmedabdalaziz/Nabta-app.git
   ```

2. **Install Flutter Dependencies**
   Navigate to the `Nabta` project folder and run:
   ```
   flutter pub get
   ```

3. **Install Backend Dependencies**
   Navigate to the backend folder (`backend/`) and install the required Node.js packages:
   ```
   npm install
   ```

4. **Run the App**
   To run the app on your device/emulator:
   ```
   flutter run
   ```

5. **Run the Backend**
   To start the backend server:
   ```
   npm start
   ```

---

## Future Features

- **AI-Enhanced Farming Suggestions**: Provide personalized farming advice based on user data.
- **IoT Integration**: Integrate with smart farming devices to monitor crop health, soil moisture, and more.
- **Multi-Language Support**: Expand the app's accessibility to a broader audience by adding more languages.

---

## Contributing

We welcome contributions from the community! If you'd like to contribute to the development of **Nabta**, feel free to fork the repository, make your changes, and submit a pull request.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- AI Model for Plant Disease Detection: **[Insert source or framework]**
- Special thanks to the open-source community for their contributions to this project.

---

