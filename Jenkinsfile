node {
  stage('SCM') {
    checkout scm
  }

  stage('SonarQube Analysis') {
    // get your scanner installation
    def scannerHome = tool 'SonarScanner for MSBuild'
    withSonarQubeEnv('sonardelphi') {
    // manually set SONAR_HOST_URL and SONAR_AUTH_TOKEN, or rely on your own env vars
    bat """
      \"${scannerHome}\\SonarScanner.MSBuild.exe\" begin ^
        /k:\"OmniDevOps_2025\" ^
        /d:sonar.host.url=%SONAR_HOST_URL% ^
        /d:sonar.login=%SONAR_AUTH_TOKEN%

      msbuild YourSolution.sln

      \"${scannerHome}\\SonarScanner.MSBuild.exe\" end ^
        /d:sonar.login=%SONAR_AUTH_TOKEN%
    """
  }
}
