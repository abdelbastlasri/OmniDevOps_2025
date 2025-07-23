node {
    stage('SCM') {
        checkout scm
    }

    stage('SonarQube Pre‑Analysis') {
        // Récupère l'installation du scanner que vous avez nommé "SonarScanner for MSBuild"
        def scannerHome = tool 'SonarScanner for MSBuild'

        // Injecte SONAR_HOST_URL et SONAR_AUTH_TOKEN depuis la config "sonardelphi"
        withSonarQubeEnv('sonardelphi') {
            bat "\"${scannerHome}\\SonarScanner.MSBuild.exe\" begin " +
                "/k:\"OmniDevOps_2025\" " +
                "/d:sonar.host.url=%SONAR_HOST_URL% " +
                "/d:sonar.login=%SONAR_AUTH_TOKEN%"
        }
    }

    stage('Build .NET Solution') {
        // Adaptez le chemin/nom de votre solution ou projet MSBuild ici
        bat 'msbuild YourSolution.sln /t:Rebuild'
    }

    stage('SonarQube Post‑Analysis') {
        def scannerHome = tool 'SonarScanner for MSBuild'
        bat "\"${scannerHome}\\SonarScanner.MSBuild.exe\" end " +
            "/d:sonar.login=%SONAR_AUTH_TOKEN%"
    }
}  // <-- Fermeture du bloc node
