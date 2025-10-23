// Top-level build file where you can add configuration options common to all sub-projects/modules.

buildscript {
    repositories {
        google()       // ✅ Required for Firebase & Android Gradle Plugin
        mavenCentral() // ✅ Common dependency source
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.5.2")
        classpath("com.google.gms:google-services:4.4.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Optional: if you have custom build directory structure
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    layout.buildDirectory.set(newSubprojectBuildDir)
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
