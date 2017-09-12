RAACIPST ;HISC/CAH - postinit for patch 8 ;10/23/96  16:26
 ;;4.5;Radiology/Nuclear Medicine;**8**;Dec 12, 1995
EN1 ;For each imaging loc, get file 44 pointer, DSS ID, Div
 ;and give to MAS to set/reset params on the file 44 entry
 N RA791,RA44,RA44NM,RA44NM2,RADSS,RADSSNM,RADIV,RAERRCNT,RA44NEW,RATRY
 S RA791=0 F  S RA791=$O(^RA(79.1,RA791)) Q:'RA791  D
 . S RAERRCNT=0,RA44NM2=""
 . S RA791(0)=$G(^RA(79.1,+RA791,0))
 . S RA44=$P(RA791(0),"^",1) I '$D(^SC(+RA44,0)) D ERR44
 . S RA44NM=$P($G(^SC(+RA44,0)),"^",1)
 . S RADSS=$P(RA791(0),"^",22) I 'RADSS D ERRDSS
 . S RADSSNM=$P($G(^DIC(40.7,+RADSS,0)),"^",2)
 . S RADIV=$G(^RA(79.1,+RA791,"DIV")) I 'RADIV D ERRDIV
 . I RAERRCNT Q  ;If this Img Loc has an error, stop here
 . ;Call MAS Sched'g routine with img loc data
 . S RA44NEW=$$RAD^SCDXUAPI(RA44,"RA") ;returns ien of same or new loc
 . I +RA44NEW=-1 D ERRMSG(RA44NEW) Q  ; explain why $$RAD call failed
 . I RA44NEW'=RA44 D REPOINT
 . S RATRY=$$LOC^SCDXUAPI($S($L(RA44NM2):RA44NM2,1:RA44NM),RADIV,RADSSNM,"RA",RA44)
 . I +RATRY=-1 D ERRMSG(RATRY)
 . I +RATRY'=-1 D OK
 . Q
 D DEL148 ; delete 'Telephone/Diagnostic' (148) Stop Code from 71.5
 Q
ERR44 ;bad file 44 pointer
 N TXT S RAERRCNT=RAERRCNT+1
 S TXT(1)="Imaging Location file #79.1 internal entry #"_RA44
 S TXT(2)="is a broken pointer to Hospital Location file #44."
 S TXT(3)="IRM must resolve this problem, then the Rad/Nuc Med ADPAC"
 S TXT(4)="should use the Location Parameter Set-up [RA SYSLOC] option"
 S TXT(5)="to edit this Imaging Location, and the Division Parameter"
 S TXT(6)="Set-up [RA SYSDIV] option to assign it to a division."
 S TXT(7)=" " D MES^XPDUTL(.TXT)
 Q
ERRDSS ;bad file 40.7 pointer (DSS ID/Stop Code)
 N TXT S RAERRCNT=RAERRCNT+1
 S TXT(1)="Imaging Location file #79.1 entry "_$S($L(RA44NM):RA44NM,1:RA44)_" has a missing or"
 S TXT(2)="invalid DSS ID.  The Radiology/Nuclear Medicine ADPAC should"
 S TXT(3)="use the Location Parameter Set-up [RA SYSLOC] option to enter"
 S TXT(4)="a valid imaging DSS Code for this imaging location."
 S TXT(5)=" " D MES^XPDUTL(.TXT)
 Q
ERRDIV ;bad or non-existent Division on active imaging loc
 N TXT S RAERRCNT=RAERRCNT+1
 S TXT(1)="Imaging Location file #79.1 entry "_$S($L(RA44NM):RA44NM,1:RA44)_" is not assigned"
 S TXT(2)="to a Rad/Nuc Med Division. If Imaging exams are to be registered"
 S TXT(3)="in this imaging location, or if there are incomplete exams"
 S TXT(4)="already registered to this location, the Radiology/Nuclear"
 S TXT(5)="Med ADPAC should use the Division Parameter Set-up [RA SYSDIV]"
 S TXT(6)="option to assign this imaging location to the appropriate"
 S TXT(7)="Rad/Nuc Med Division."
 S TXT(8)=" " D MES^XPDUTL(.TXT)
 Q
ERRMSG(RAX)      ; Explain why the $$RAD call failed.
 N TXT S TXT(1)="Scheduling routine could not reset Hospital Location"
 S TXT(2)="file #44 params for Imaging Location "_$S($L(RA44NM2):RA44NM2,1:RA44NM)
 S TXT(3)="to agree with params on the Imaging Location file #79.1."
 S TXT(4)="IRM should investigate the cause of this Scheduling error message:"
 S TXT(5)=" * "_$P(RAX,"^",3)_" * "
 S TXT(6)=" " D MES^XPDUTL(.TXT)
 Q
REPOINT ;current img loc points to a file 44 entry with appt patterns
 ;must be repointed to the loc Sched'g returned to us
 ;
 ;call DIE or Silent FM to change .01 fld of file 79.1 to RA44NEW
 ;use equivalent of /// stuff, and give a message about old imaging
 ;loc name changing to new name
 ;
 N TXT,RAERR,RAFDA
 S RA44=RA44NEW,RA44NM2=$P($G(^SC(+RA44NEW,0)),"^",1)
 S RAFDA(79.1,RA791_",",.01)=RA44NEW
 D FILE^DIE("K","RAFDA","RAERR")
 S TXT(1)="Imaging Location "_RA44NM_" has appointment patterns, and"
 S TXT(2)="cannot be 'pointed to' from a file 79.1 Imaging Location."
 S TXT(3)="Imaging Location "_RA44NM_" has been 're-pointed' to"
 S TXT(4)="Hospital Location "_RA44NM2_"."
 S TXT(5)=" " D MES^XPDUTL(.TXT)
 Q
OK ;this img loc was processed ok
 N TXT
 S TXT(1)="Imaging Location "_$S($L(RA44NM2):RA44NM2,1:RA44NM)_" is OK."
 S TXT(2)=" " D MES^XPDUTL(.TXT)
 Q
DEL148 ; Delete 'Telephone/Diagnostic' Stop Code from the Imaging Stop Codes
 ; file.  Data resides in ^RAMIS(71.5,
 N %,DA,DIC,DIK,I,RA407,RARRY,RASTOP,TXT,X,Y S (I,RASTOP)=0
 S TXT(1)="Deleting the 'Telephone/Diagnostic' Stop Code from the"
 S TXT(2)="Imaging Stop Codes (71.5) file.",TXT(3)=" "
 F  S I=$O(^RAMIS(71.5,I)) Q:I'>0  D  Q:RASTOP
 . S RA407(1)=+$P($G(^RAMIS(71.5,I,0)),"^")
 . D GETS^DIQ(40.7,RA407(1)_",",1,"","RARRY")
 . I $G(RARRY(40.7,RA407(1)_",",1))=148 D  Q
 .. S RASTOP=1,DA=I,DIK="^RAMIS(71.5," D ^DIK
 .. D BMES^XPDUTL(.TXT)
 .. Q
 . K RARRY
 . Q
 Q
