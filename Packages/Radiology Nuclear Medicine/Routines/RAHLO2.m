RAHLO2 ;HIRMFO/GJC-File rpt (data from bridge program) ;10/30/97  09:02
 ;;5.0;Radiology/Nuclear Medicine;**55,80,84**;Mar 16, 1998;Build 13
 ;
 ;Integration Agreements
 ;----------------------
 ;$$FIND1^DIC(2051); UPDATE^DIE(2053); $$DT^XLFDT(10103); $$UP^XLFSTR(10104)
 ;
ADENDUM ; This functions store new lines of text at the end of the existing 
 ;impression and report text. If this report is being amended through the
 ;teleradiology service, add the addendum text to the IMPRESSION TEXT (#300)
 ;field only. Note: Only ADENDUM was edited for RA*5.0*84 gjc/09.18.07
 N A,COUNTER,I,J,NODE,ROOT,SUB,X,Y
 ;NODE = ^RARPT(RARPT,"I" -or- "R"  -> where the data is to be stored...
 ;ROOT = ^TMP("RARPT-REC",$J,RASUB  -> where the addendum data resides...
 F A="I","R" D  K I,J
 .S SUB=$S(A="I":"RAIMP",1:"RATXT"),ROOT=$NA(^TMP("RARPT-REC",$J,RASUB,SUB)) Q:'$O(@ROOT@(0))
 .S NODE=$NA(^RARPT(RARPT,A))
 .S COUNTER=+$O(@NODE@($C(32)),-1) ;last record #
 .;
 .;if there is existing text, add a null line for space.
 .I '($D(I)#2),(COUNTER>0) S COUNTER=COUNTER+1,@NODE@(COUNTER,0)=$C(32),I=""
 .;
 .S Y=0 F  S Y=$O(@ROOT@(Y)) Q:'Y  D
 ..S X=@ROOT@(Y)
 ..;if addendum text is to be the original text no spacer is needed ('Addendum:' tag applied)
 ..;if prior report or impression text exist, insert a blank as a spacer
 ..;^RARPT(RARPT,"I",1,0)="original impression"
 ..;^RARPT(RARPT,"I",2,0)="" <- insert a null line as a spacer
 ..;^RARPT(RARPT,"I",3,0)="Addendum: first line of addendum" ** NOTE 'Addendum:' tag **
 ..;^RARPT(RARPT,"I",4,0)="second line of addendum"
 ..;...
 ..;^RARPT(RARPT,"I",N,0)="Nth and last line of addendum"
 ..S COUNTER=COUNTER+1
 ..;set the first line of the addendum w/header: 'Addendum: '
 ..I '($D(J)#2) S X="Addendum: "_X,J=""
 ..S @NODE@(COUNTER,0)=X
 ..Q
 .S @NODE@(0)="^^"_COUNTER_"^"_COUNTER_"^"_$$DT^XLFDT()
 .Q
 Q
 ;
ERR(A) ; Invalid impression/report text message.
 ; Input: 'A' - either "I" for impression, or "R" for report
 ; Output: the appropriate error message
 Q "Invalid "_$S(A="I":"Impression",1:"Report")_" Text"
 ;
DIAG ; Check if the Diagnostic Codes passed are valid.  Set RADX equal
 ; to primary Dx code pntr value.  Set RASECDX(x) to the secondary
 ; Dx code(s) if any.
 N RAXFIRST
 S I=0,RAXFIRST=1
 K RASECDX
 F  S I=$O(^TMP("RARPT-REC",$J,RASUB,"RADX",I)) Q:I'>0  D  Q:$D(RAERR)
 . S RADIAG=$G(^TMP("RARPT-REC",$J,RASUB,"RADX",I))
 . ;S:RADIAG']"" RAERR="Missing Diagnostic Code" Q:$D(RAERR)
 . Q:RADIAG']""  ;Missing Diagnostic Code  Patch 80
 . ; If RADXIEN is a number, set RADXIEN to what is assumed to be a
 . ; valid pointer (ien) for file 78.3
 . I +RADIAG=RADIAG S RADXIEN=RADIAG
 . ; If RADIAG is in a free text format, convert the external value
 . ; into the ien for file 78.3
 . I +RADIAG'=RADIAG S RADXIEN=$$FIND1^DIC(78.3,"","X",RADIAG)
 . I '$D(^RA(78.3,RADXIEN,0)) S RAERR="Invalid Diagnostic Code" Q
 . IF RAXFIRST S RADX=RADXIEN,RAXFIRST=0 Q  ; RADX=pri. Dx Code
 . ; are any of the sec. Dx codes equal to our pri. Dx code?
 . ;S:RADXIEN=RADX RAERR="Secondary Dx codes must differ from the primary Dx code." Q:$D(RAERR)
 . Q:RADXIEN=RADX  ;Secondary Dx codes must differ from the primary Dx code  Patch 80
 . ;S:$D(RASECDX(RADXIEN))#2 RAERR="Duplicate secondary Dx codes." Q:$D(RAERR)
 . Q:$D(RASECDX(RADXIEN))#2  ;Duplicate secondary Dx codes. Patch 80
 . S RASECDX(RADXIEN)="" ; set the sec. Dx array
 . Q
 K I,RADIAG,RADXIEN
 Q
SECDX ; Kill old sec. Dx nodes, and add the new ones into the 70.14 multiple
 ; called from RAHLO.  Needs RADFN,RADTI & RACNI to function.
 Q:'$D(RADFN)!('$D(RADTI))!('$D(RACNI))
 I $O(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"DX",0)) D KILSECDG^RAHLO4
 ;K RAFDA N RAX S RAX=0,RAFDA(70,"?1,",.01)=RADFN
 ;S RAFDA(70.02,"?2,?1,",.01)=(9999999.9999-RADTI)
 ;S RAFDA(70.03,"?3,?2,?1,",.01)=$P($G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),"^")
 ;F  S RAX=$O(RASECDX(RAX)) Q:RAX'>0  D
 ;. S RAFDA(70.14,"?"_RAX_"9,?3,?2,?1,",.01)=RAX
 ;. Q
 ;D UPDATE^DIE("","RAFDA",,"RAERR")
 ;I $D(RAERR) M ^TMP("ERR")=RAERR
 ;
 N RAX S RAX=0
 N RAFDA,RA2
 K RAFDA
 ; K ^TMP("RAERR",$J)
 S RA2=RACNI_","_RADTI_","_RADFN
 F  S RAX=$O(RASECDX(RAX)) Q:RAX'>0  D
 . S RAFDA(70.14,"?+"_RAX_"9,"_RA2_",",.01)=RAX
 D UPDATE^DIE("","RAFDA",,"RAERR")
 ; I $D(RAERR) M ^TMP("RAERR",$J)=RAERR
 ;
 Q
IMPTXT ; Check if the impression text consists only of the string
 ; 'impression:".  If 'impression:' is the only set of characters,
 ; (spaces are excluded) then delete the "RAIMP" node.
 N RA1 S RA1=$O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",0))
 Q:'RA1  N RAIMP S RAIMP=$G(^TMP("RARPT-REC",$J,RASUB,"RAIMP",RA1))
 I $$UP^XLFSTR($E(RAIMP,1,11))="IMPRESSION:" D
 . S $E(RAIMP,1,11)="" ; strip out 'impression:' if it is the first
 . ;                     eleven chars of the impression text
 . ; now strip off leading spaces from the remaining
 . ; text that led with 'impression:' if present
 . F I1=1:1 S:$E(RAIMP,I1)'=" " RAIMP=$E(RAIMP,I1,99999) Q:$E(RAIMP)'=" "
 . S ^TMP("RARPT-REC",$J,RASUB,"RAIMP",RA1)=RAIMP
 . Q
 Q:$O(^TMP("RARPT-REC",$J,RASUB,"RAIMP",RA1))  ; more imp. text follows
 K:$G(^TMP("RARPT-REC",$J,RASUB,"RAIMP",RA1))="" ^TMP("RARPT-REC",$J,RASUB,"RAIMP",RA1) ; if only "RAIMP" node null, delete "RAIMP" node
 Q
