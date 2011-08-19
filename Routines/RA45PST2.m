RA45PST2 ;Hines OI/GJC - Post-init 'B', patch 45 ;10/10/03  06:32
VERSION ;;5.0;Radiology/Nuclear Medicine;**45**;Mar 16, 1998
 ;
ENQ2 ;The second process must be tasked off that will identify all the
 ;non-parent Rad/Nuc Med orderable items (OI) in file 101.43 checking
 ;them to see if barium, oral cholecystogram or unspecified contrast
 ;media happen to be associated contrasts.
 ;
 ;If no associations move onto the next OI and check for CMs
 ;
 ;If yes, update the procedure in file 71; add barium, oral
 ;cholecystografic or unspecified contrast media to the CONTRAST MEDIA
 ;(#125) multiple in file 71. All successful and unsuccessful updates
 ;will be presented to the user in the form of an email message.
 ;(Failure to update occurs when a record cannot be locked)
 ;
 ;Finally, the Rad/Nuc Med Procedure (71) file will be synchronized with
 ;the Orderable Items (101.43) file.
 ;
 ;Note: since parent procedure records resident in the OI file prior
 ;to RA*5*45 did not have CM associations synchronizing files 101.43 &
 ;71 will occur just before processing is finished.
 ;
 S:$D(ZTQUEUED) ZTREQ="@" S RAX="",(RACT,ZTSTOP)=0
 F  S RAX=$O(^ORD(101.43,"S.XRAY",RAX)) Q:RAX=""  D  Q:ZTSTOP
 .S RAY=0 F  S RAY=$O(^ORD(101.43,"S.XRAY",RAX,RAY)) Q:'RAY  D
 ..S RAOIRA=$G(^ORD(101.43,RAY,"RA")),RAOICM=$P(RAOIRA,U) Q:RAOICM=""
 ..S RAOIPT=$P(RAOIRA,U,2) Q:("^B^P^")[("^"_RAOIPT_"^")
 ..;parents have no descendents in 101.43 & broads have no CPTs quit
 ..S RAOI=$G(^ORD(101.43,RAY,0)),RAOI(2)=$P(RAOI,U,2)
 ..Q:$P(RAOI(2),";",2)'="99RAP"  ;just to be on the safe side...
 ..;update file 71 with CM data, lock the record if lock fails quit
 ..;record will not be updated in this case
 ..L +^RAMIS(71,+RAOI(2)):30
 ..I '$T D SETMP(+RAOI(2),$E($P(RAOI,U),1,40),"",RAOICM,"*failed*",1) Q
 ..F RAI=1:1:$L(RAOICM) D FILECM(+RAOI(2),$E(RAOICM,RAI),RAI)
 ..L -^RAMIS(71,+RAOI(2)) ;unlock
 ..;identify those records in file 71 that have been updated; the
 ..;user will be made aware of rad/nuc med procedure updates via email
 ..S RAMIS(0)=$G(^RAMIS(71,+RAOI(2),0)),RAPNAME=$P(RAMIS(0),U)
 ..S RACT=RACT+1 S:RACT#200=0 ZTSTOP=$$S^%ZTLOAD()
 ..S RACPT=$P($$CPT^ICPTCOD($P(RAMIS(0),U,9)),U),RACPT=$S(RACPT=-1:"none",1:RACPT)
 ..D SETMP(+RAOI(2),$E(RAPNAME,1,40),RACPT,RAOICM,"*done*",1)
 ..Q
 .Q
 ;
 ;if the user stopped this process via TaskMan (TM) inform the user
 D:ZTSTOP=1 STOP
 ;
 ;if there has been data updated, let the user know through an email
 ;even if the user stopped the task via TaskMan (TM)
 I +$O(^TMP("RA PROC UPDATE 45",$J,0)) D MAILQ2^RA45PST(1,"RA*5*45: Update Rad/NM CM definitions from Ord. Item CM definitions")
 ;
 ;user stopped the process, do not proceed kill variables and quit
 I ZTSTOP=1 D KILLQ2 Q
 ;
 ;make sure the all from file 71 get updated in file 101.43; ZTSTOP
 ;exists and is set to zero.
 ;RAO7MFN takes care of: skipping broad procedures, skipping inactive
 ;procedures, & flagging parent procedure with contrasts if a non-broad
 ;descendent has contrasts.
 S (RACT,RAY)=0 K ^TMP("RA PROC UPDATE 45",$J)
 F  S RAY=$O(^RAMIS(71,RAY)) Q:'RAY  D  Q:ZTSTOP
 .S RAMIS(0)=$G(^RAMIS(71,RAY,0)),RAPNAME=$E($P(RAMIS(0),U),1,40)
 .S RASTAT=+$G(^RAMIS(71,RAY,"I")),RASTAT=$S(RASTAT=0:1,RASTAT>DT:1,1:0)
 .S RAPTY=$P(RAMIS(0),U,6),RAPTY=$S(RAPTY="P":"(p)",1:"")
 .S RACPTB=$P($$CPT^ICPTCOD($P(RAMIS(0),U,9)),U),RACPTB=$S(RACPTB=-1:"none",1:RACPTB),RAPNAME=RAPNAME_RAPTY
 .;build Rad/Nuc Med procedure file based contrast media string
 .S (I,RACM)=""
 .F  S I=$O(^RAMIS(71,RAY,"CM","B",I)) Q:I=""  S RACM=RACM_I
 .;
 .;update file 71 with CM data; attempt lock, if lock fails quit
 .;record will not be updated if a lock attempt fails
 .K I S RACT=RACT+1 S:RACT#50=0 ZTSTOP=$$S^%ZTLOAD()
 .Q:ZTSTOP  L +^RAMIS(71,RAY):30
 .I '$T D SETMP(RAY,RAPNAME,RACPTB,RACM,"*failed*",2) Q
 .D PROC^RAO7MFN(0,71,"1^"_RASTAT,RAY_"^"_RAPNAME)
 .;1st parameter (param) indicates a single procedure update; 2nd param
 .;indicates the file being edited (RAD/NUC MED PROCEDURE); 3rd param
 .;indicates the 'before & after' status of the procedure after an
 .;edit event ('before' status always active to guarantee unconditional
 .;OI file updates); 4th param indicates the IEN (1st piece) and name
 .;(2nd piece) of the procedure in file 71
 .L -^RAMIS(71,RAY) ;unlock...
 .D SETMP(RAY,RAPNAME,RACPTB,RACM,"*done*",2)
 .Q
 ;
 ;if the user stopped this process via TaskMan (TM) inform the user
 D:ZTSTOP=1 STOP
 ;
 ;if there has been data updated, let the user know through an email
 I +$O(^TMP("RA PROC UPDATE 45",$J,0)) D MAILQ2^RA45PST(2,"RA*5*45: Synch up the Rad/Nuc Med Procedure & Orderable Item files")
 ;
KILLQ2 ;kill & quit
 K RACM,RACT,RACPT,RACPTB,RAI,RAMIS,RAOI,RAOICM,RAOIPT,RAOIRA,RAPNAME
 K RAPTY,RASTAT,RAX,RAY,ZTSTOP,^TMP("RA PROC UPDATE 45",$J)
 Q
 ;
FILECM(RAIEN,RACM,RAI) ;Files contrast medium into the CONTRAST MEDIA (#125)
 ;field in the RAD/NUC MED PROCEDURE (#71) file. Set the 'CONTRAST MEDIA
 ;USED' field (20) to 'Y'es on the initial pass into FILECM (when RAI=1)
 ;Input
 ; RAIEN=IEN of rad/nuc med procedure in file 71
 ;  RACM=I (Iodinated ionic); N (Iodinated non-ionic); L (Gadolinium);
 ;       C (Oral Cholecystographic); G (Gastrografin); B (Barium);
 ;       M (unspecified contrast media)
 ;   RAI=position of a particular character in a data string 
 ;
 Q:$D(^RAMIS(71,RAIEN,"CM","B",RACM))\10  ;prevents duplicate records
 K RAFDA S RAD1=+$O(^RAMIS(71,RAIEN,"CM",$C(32)),-1)+1
 S:RAI=1 RAFDA(71,RAIEN_",",20)="Y"
 S RAFDA(71.0125,"+"_RAD1_","_RAIEN_",",.01)=RACM
 D UPDATE^DIE("","RAFDA") K RAD1,RAFDA
 Q
 ;
SETMP(SUB,NME,CPT,CMU,MSG,FMT) ;set the ^TMP("RA PROC UPDATE 45",$J) global
 ;with procedure information
 ;input: SUB=IEN of Rad/Nuc Med Procedure (Orderable Item ID fld value)
 ;       NME=procedure name
 ;       CPT=procedure CPT
 ;       CMU=contrast media (see RACM definition for FILECM subroutine)
 ;       MSG=indicator *done* or *failed*
 ;       FMT=format for data in email(column position 80 chars wide max) 
 N I,RAX,RAY S $P(RAY," ",81)="",RAX=""
 F I=1:1:$L(CMU) S RAX=RAX_$E(CMU,I)_$S($L(CMU)>I:",",1:"")
 S $E(RAY,1,8)=$G(MSG),$E(RAY,10,50)=$G(NME)
 S:FMT=1 $E(RAY,52,59)=$G(CPT)
 S:FMT=2 $E(RAY,55,60)=$G(CPT)
 S:FMT=1 $E(RAY,60,70)=$G(RAX)
 S:FMT=2 $E(RAY,65,77)=$G(RAX)
 S ^TMP("RA PROC UPDATE 45",$J,SUB)=RAY
 Q
 ;
STOP ;inform the user that the task has been stopped
 S ^TMP("RA PROC UPDATE 45",$J,$$SUB())="RA*5*45's Orderable Items-Rad/Nuc Med Proc. synchronization has been terminated prematurely"
 Q
 ;
SUB() ;return the next available subscript (arithmetic progression)
 Q +$O(^TMP("RA PROC UPDATE 45",$J,$C(32)),-1)+1
 ;
