node {
    def msbuildHome = tool 'My_MSBuild'
    def scannerHome = tool 'SonarScanner for MSBuild'

    stage('Checkout') {
        checkout scm
    }

    stage('SonarQube Pre‑Analysis') {
        withSonarQubeEnv('sonardelphi') {
            bat "\"${scannerHome}\\SonarScanner.MSBuild.exe\" begin /k:\"OmniDevOps_2025\" /d:sonar.host.url=%SONAR_HOST_URL% /d:sonar.login=%SONAR_AUTH_TOKEN%"
        }
    }

    stage('Build') {
        bat "\"${msbuildHome}\\MSBuild.exe\" \"${env.WORKSPACE}\\OmniDevOps_2025.sln\" /t:Rebuild /p:Configuration=Release"
    }

    stage('SonarQube Post‑Analysis') {
        bat "\"${scannerHome}\\SonarScanner.MSBuild.exe\" end /d:sonar.login=%SONAR_AUTH_TOKEN%"
    }

    stage('Quality Gate') {
        timeout(time: 5, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
