       IDENTIFICATION DIVISION.
       PROGRAM-ID. CH5SOLUTION.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT ACMEEMPLOYEES ASSIGN TO "ACME.DAT"
        FILE STATUS IS FILE-CHECK-KEY
		ORGANIZATION IS LINE SEQUENTIAL.

	   SELECT FUSESEMPLOYEES ASSIGN TO "FUSESINC.DAT"
	     ORGANIZATION IS LINE SEQUENTIAL.
    
       SELECT SORTEDFILE ASSIGN TO "EMPLOYEES.NEW"
        ORGANIZATION IS LINE SEQUENTIAL.
		
       SELECT WORKFILE ASSIGN TO "WORK.TMP".
	               
       DATA DIVISION.
       FILE SECTION.
	   FD ACMEEMPLOYEES.
	   01 ACMEDETAILS     PIC X(47).
	
       FD FUSESEMPLOYEES.
	   01 FUSESDETAILS  PIC X(47).
	
			
       FD SORTEDFILE.
	   01 SORTDETAILS        PIC X(47).
				
				
       SD WORKFILE.
       01 WORKREC.
          	02 WF-SSN        PIC 9(9).
			02 FILLER        PIC X(38).	   
   
       WORKING-STORAGE SECTION.
       01  WS-WORKING-STORAGE.
           05 FILLER      PIC X(27) VALUE 
		      'WORKING STORAGE STARTS HERE'.
     
   
	   01  WS-WORK-AREAS.
	       05  FILE-CHECK-KEY   PIC X(2).
		 

       PROCEDURE DIVISION.
       0100-READ-EMPLOYEES.

		   OPEN INPUT ACMEEMPLOYEES, FUSESEMPLOYEES.
		   				
		   MERGE WORKFILE ON ASCENDING KEY 
		      WF-SSN
		      USING ACMEEMPLOYEES 
			    FUSESEMPLOYEES
			  GIVING SORTEDFILE.
		 
		   PERFORM 9000-END-PROGRAM.
		   
	   0100-END.
	   
	   
	   9000-END-PROGRAM.
           CLOSE ACMEEMPLOYEES. 
              
           STOP RUN.
           
          END PROGRAM CH5SOLUTION.
