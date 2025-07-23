pipeline {
  agent any
  environment {
    PROJECT_KEY = 'OmniDevOps_2025'
  }
  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }
    stage('Build') {
      steps {
        bat 'msbuild OmniDevOps_2025.sln /t:Rebuild'
      }
    }
    stage('SonarQube Analysis') {
      steps {
        script {
          def scannerHome = tool name: 'SonarScanner for MSBuild', type: 'hudson.plugins.sonar.MsBuildSQRunnerInstallation'
          withSonarQubeEnv('sonardelphi') {
            bat """
\"${scannerHome}\\SonarScanner.MSBuild.exe\" begin ^
  /k:\"${env.PROJECT_KEY}\" ^
  /d:sonar.host.url=%SONAR_HOST_URL% ^
  /d:sonar.login=%SONAR_AUTH_TOKEN%

msbuild YourSolution.sln /t:Rebuild

\"${scannerHome}\\SonarScanner.MSBuild.exe\" end ^
  /d:sonar.login=%SONAR_AUTH_TOKEN%
"""
          }
        }
      }
    }
    stage('Quality Gate') {
      steps {
        timeout(time: 5, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
    }
  }
  post {
    always {
      echo "Build finished with status: ${currentBuild.currentResult}"
    }
  }
}
