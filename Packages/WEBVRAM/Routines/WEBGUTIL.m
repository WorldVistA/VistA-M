WEBGUTIL ; SLC/JAS - WEBG*3*13 WEBVRAM VISTA UTILITIES; May 3, 2023@9:20 AM
 ;;3.0;WEB VISTA REMOTE ACCESS MANAGEMENT;**13**;Apr 06, 2021;Build 1
 ;;Per VHA Directive 6402, this routine should not be modified
 ;
 ; GETLST^XPAR - Supported by ICR 2263
 ;
 Q
 ;
VERSRV(RETDLL) ; Return server version(s) for Vitals DLL
 ;
 ; Output: Active GMRV/VITALS DLL Version(s) in array format
 ;
 N ENTITY,ERR,PARAM,RESCNT,RESULTS,VERCNT
 S VERCNT=0
 S ENTITY="SYS"
 S PARAM="GMV DLL VERSION"
 ;
 D GETLST^XPAR(.RESULTS,ENTITY,PARAM,"E",.ERR)
 ;
 ; Exception checking
 ;
 I $G(ERR,0) D  Q
 . S RETDLL(VERCNT)="An error has occurred."
 I '$D(RESULTS) D  Q
 . S RETDLL(VERCNT)="No entries found."
 ;
 ; Filter out inactive results
 ;
 F RESCNT=1:1:RESULTS D
 . I $P($G(RESULTS(RESCNT)),"^",2)="YES" D
 . . S VERCNT=VERCNT+1
 . . S RETDLL(VERCNT)=$P($G(RESULTS(RESCNT)),"^")
 ;
 I 'VERCNT S RETDLL(VERCNT)="No active versions." Q
 ;
 S RETDLL(0)=VERCNT
 ;
 Q
