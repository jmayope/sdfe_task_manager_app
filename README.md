# 📝 SDFe Task Manager App

**SDFe Task Manager App** es una aplicación móvil desarrollada en Flutter que permite a los usuarios gestionar sus tareas de forma rápida, organizada y segura. Ofrece autenticación, almacenamiento en la nube y una experiencia de usuario eficiente mediante el uso del patrón GetX.

## 🚀 Características principales

- ✅ Autenticación de usuarios con Firebase Auth
- 🔐 Almacenamiento seguro con `flutter_secure_storage`
- 🔥 Base de datos en tiempo real con Firebase Realtime Database
- 📡 Comunicación HTTP
- ⚙️ Gestión de estado, rutas y dependencias usando **GetX**
- 💾 Persistencia de datos confiable
- 📱 Interfaz limpia y adaptable con diseño Material

## 🛠️ Tecnologías utilizadas

- **Flutter SDK**: ^3.7.2
- **Firebase Core**: ^3.13.0
- **Firebase Auth**: ^5.5.2
- **Firebase Realtime Database**: ^11.3.5
- **GetX**: ^4.7.2
- **Flutter Secure Storage**: ^9.2.4
- **HTTP**: ^1.3.0
- **Quiver**: ^3.2.2

## 📷 Capturas de pantalla

Estan en el documento adjunto.

## 🔧 Instalación

1. **Clonar el repositorio:**

   ```bash
   git clone https://github.com/tu_usuario/sdfe_task_manager_app.git
   cd sdfe_task_manager_app

2. **Instalación de Dependencias**

   ```bash
   flutter pub get

3. **Ejecutar la Aplicación**

    ```bash
    flutter run

    ***tener configurado un dispositivo emulador o un dispositivo físico conectado.
4. **Estructura del Proyecto**
  ```lib/
  ├── app
  │   ├── data
  │   │   └── services
  │   ├── modules
  │   │   ├── home
  │   │   │   ├── bindings
  │   │   │   ├── controllers
  │   │   │   └── views
  │   │   ├── login
  │   │   │   ├── bindings
  │   │   │   ├── controllers
  │   │   │   └── views
  │   │   ├── profile
  │   │   │   ├── bindings
  │   │   │   ├── controllers
  │   │   │   └── views
  │   │   ├── register
  │   │   │   ├── bindings
  │   │   │   ├── controllers
  │   │   │   └── views
  │   │   └── task_detail
  │   │       ├── bindings
  │   │       ├── controllers
  │   │       └── views
  │   └── routes
  └── models


