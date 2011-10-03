RASYS1 ;HISC/CAH - Utility to update I-Loc Type to Clinic ;10/30/96  10:00
 ;;5.0;Radiology/Nuclear Medicine;;Mar 16, 1998
EN1(RA791) ;For each imaging loc, get file 44 pointer, DSS ID, Div
 ;and give to MAS to set/reset params on the file 44 entry
 ; Input: -> ien of entry in the 'Imaging Locations' file (79.1)
 N RA44,RA44NM,RA44NM2,RADSS,RADSSNM,RADIV,RAERRCNT,RA44NEW,RATRY
 S RAERRCNT=0,RA44NM2=""
 S RA791(0)=$G(^RA(79.1,+RA791,0))
 S RA44=$P(RA791(0),"^",1) I '$D(^SC(+RA44,0)) D ERR44 Q:RAXIT
 S RA44NM=$P($G(^SC(+RA44,0)),"^",1)
 S RADSS=$P(RA791(0),"^",22) I 'RADSS D ERRDSS Q:RAXIT
 S RADSSNM=$P($G(^DIC(40.7,+RADSS,0)),"^",2)
 S RADIV=$G(^RA(79.1,+RA791,"DIV")) I 'RADIV D ERRDIV Q:RAXIT
 I RAERRCNT Q  ;If this Img Loc has an error, stop here
 ;Call MAS Sched'g routine with img loc data
 S RA44NEW=$$RAD^SCDXUAPI(RA44,"RA") ;returns ien of same or new loc
 I +RA44NEW=-1 D ERRMSG(RA44NEW) Q  ; explain why $$RAD call failed
 I RA44NEW'=RA44 D REPOINT
 S RATRY=$$LOC^SCDXUAPI($S($L(RA44NM2):RA44NM2,1:RA44NM),RADIV,RADSSNM,"RA",RA44)
 I +RATRY=-1 D ERRMSG(RATRY)
 I +RATRY'=-1 D OK
 Q
ERR44 ;bad file 44 pointer
 S RAERRCNT=RAERRCNT+1
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Imaging Location file #79.1 internal entry #"_RA44
 W !,"is a broken pointer to Hospital Location file #44."
 W !,"IRM must resolve this problem, then the Rad/Nuc Med ADPAC"
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"should use the Location Parameter Set-up [RA SYSLOC] option"
 W !,"to edit this Imaging Location, and the Division Parameter"
 W !,"Set-up [RA SYSDIV] option to assign it to a division.",!," "
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 Q
ERRDSS ;bad file 40.7 pointer (DSS ID/Stop Code)
 S RAERRCNT=RAERRCNT+1
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Imaging Location file #79.1 entry "_$S($L(RA44NM):RA44NM,1:RA44)_" has a missing"
 W !,"or invalid DSS ID.  The Radiology/Nuclear Medicine ADPAC should"
 W !,"use the Location Parameter Set-up [RA SYSLOC] option to enter"
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"a valid imaging DSS Code for this imaging location.",!," "
 Q
ERRDIV ;bad or non-existent Division on active imaging loc
 S RAERRCNT=RAERRCNT+1
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Imaging Location file #79.1 entry "_$S($L(RA44NM):RA44NM,1:RA44)_" is not assigned"
 W !,"to a Rad/Nuc Med Division. If Imaging exams are to be registered"
 W !,"in this imaging location, or if there are incomplete exams"
 W !,"already registered to this location, the Radiology/Nuclear"
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Med ADPAC should use the Division Parameter Set-up [RA SYSDIV]"
 W !,"option to assign this imaging location to the appropriate"
 W !,"Rad/Nuc Med Division.",!," "
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 Q
ERRMSG(RAX) ; Explain why the $$RAD call failed.
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Scheduling routine could not reset Hospital Location"
 W !,"file #44 params for Imaging Location "_$S($L(RA44NM2):RA44NM2,1:RA44NM)
 W !,"to agree with params on the Imaging Location file #79.1."
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"IRM should investigate the cause of this Scheduling error message:"
 W !," * "_$P(RAX,"^",3)_" * ",!," "
 Q
REPOINT ;current img loc points to a file 44 entry with appt patterns
 ;must be repointed to the loc Sched'g returned to us
 ;
 ;call DIE or Silent FM to change .01 fld of file 79.1 to RA44NEW
 ;use equivalent of /// stuff, and give a message about old imaging
 ;loc name changing to new name
 ;
 N RAERR,RAFDA
 S RA44=RA44NEW,RA44NM2=$P($G(^SC(+RA44NEW,0)),"^",1)
 S RAFDA(79.1,RA791_",",.01)=RA44NEW
 D FILE^DIE("K","RAFDA","RAERR")
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Imaging Location "_RA44NM_" has appointment patterns, and"
 W !,"cannot be 'pointed to' from a file 79.1 Imaging Location."
 W !,"Imaging Location "_RA44NM_" has been 're-pointed' to"
 I $Y>(IOSL-6) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Hospital Location "_RA44NM2_".",!," "
 Q
OK ;this img loc was processed ok
 I $Y>(IOSL-4) S RAXIT=$$EOS^RAUTL5() Q:RAXIT  W @IOF
 W !,"Imaging Location "_$S($L(RA44NM2):RA44NM2,1:RA44NM)_" is OK.",!," "
 Q
