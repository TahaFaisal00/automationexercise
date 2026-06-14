// Declarative pipeline: runs the Robot Framework suite, then publishes the report in Jenkins.
pipeline {
    // Where to run. 'any' = any available node. On a solo local setup that's this machine.
    agent any

    stages {
        // NOTE: there is no checkout stage on purpose.
        // The job is configured as "Pipeline script from SCM", so Jenkins clones the repo
        // into the workspace automatically before this pipeline even starts.

        stage('Install Dependencies') {
            steps {
                // 'bat' runs a Windows command. (On Linux/Mac the step would be 'sh'.)
                bat 'pip install robotframework robotframework-seleniumlibrary robotframework-requests robotframework-faker'
            }
        }

        stage('Run Tests') {
            steps {
                // --variable HEADLESS:True : no visible browser window (required on a CI machine)
                // --outputdir results      : write output.xml / log.html / report.html into results/
                // --nostatusrc             : robot exits 0 even if tests fail, so the build does not
                //                            hard-fail here; the Robot plugin below decides health.
                bat 'robot --variable HEADLESS:True --outputdir results --nostatusrc Tests/'
            }
        }
    }

    post {
        // 'always' runs no matter what happened above, so a report is published on every run.
        always {
            robot(
                outputPath: 'results',
                outputFileName: 'output.xml',
                logFileName: 'log.html',
                reportFileName: 'report.html',
                passThreshold: 100.0,    // 100% pass => green (SUCCESS)
                unstableThreshold: 0.0   // below 100% => yellow (UNSTABLE), not a hard red
            )
        }
    }
}