       IDENTIFICATION DIVISION.
       PROGRAM-ID. "ENHANCEDBMICALCULATOR".
       AUTHOR .    Carlinhoshk.
      *Esse programa le um input de um arquivo.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BMI-FILE ASSIGN TO "BMI-INPUT.DAT"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT PRINT-FILE ASSIGN TO "BMI-REPORT.DAT".
           FILE SECTION.
               FD BMX-FILE.
               
               01 BMIDETAILS.
                   88 ENDOFBMI VALUE HIGH-VALUES.
               05 PERSON-NAME.
                   10 LASTNAME     PIC x(20).
                   10 FIRSTNAME    PIC x(20).
               05 HEIGHT-INCHES    PIC 999.
               05 WEIGHT           PIC 999.
               FD PRINT-FILE.
               
               
               
               