plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.car_2_go"

    // ⚠️ Versión explícita para evitar conflictos
    compileSdk = 34

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.car_2_go"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"

        // Habilita MultiDex (necesario para muchas dependencias Firebase)
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase Messaging (se añade si Flutter no lo maneja automáticamente)
    implementation("com.google.firebase:firebase-messaging:23.4.0")
    implementation("androidx.multidex:multidex:2.0.1")
    implementation("com.google.firebase:firebase-perf:20.5.2")

}

apply(plugin = "com.google.gms.google-services")
apply(plugin = "com.google.firebase.firebase-perf")
