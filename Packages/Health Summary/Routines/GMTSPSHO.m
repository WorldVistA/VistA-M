GMTSPSHO ; SLC OIFO/GS - Herbal/OTC Medications Health Summary; 01/26/2004
 ;;2.7;Health Summary;**65**;Oct 20, 1995
 ;v6;04/07/2004
 ;
 ; External References
 ;   DBIA    330  ^PSOHCSUM which includes ^TMP("PSOO",$J)
 ;   DBIA  10003  DD^%DT
 ;   DBIA  10035  ^DPT(  file #2
 ;   DBAI  10060  ^VA(200
 ;                 
 ; Format of ^TMP("PS00",$J,"NVA",ILFD,0) as G1 aka GMRC
 ;  (see also ^PSOHCSUM):
 ;                 
 ; Field Descriptions    Defined                 AKA/Notes
 ; Orderable Item        $P(G1,U)                Includes dosage form
 ;                                                 (File # 50.7)
 ; Status                $P(G1,U,2)
 ; Discontinued Date     $P(G1,U,7)              FM format
 ; Order #               $P(G1,U,4)              CPRS Order #  ptr to
 ;                                                 File #100
 ; Documented By         $P($P(G1,U,6),";",2)    Doc. by Name  ptr to
 ;                                                 File #200 is $P(x;1)
 ; Documented Date       $P(G1,U,5)              FM format (Entered On)
 ; Clinic                $P($P(G2,U,5),";",2)    Clinic Name  ptr to
 ;                                                 File #44 is $P(x;1)
 ; Date Started          $P(G1,U,3)              FM format (Start Date)
 ; Drug                  $P($P(G2,U,4),";",2)    Drug name (Dispensed)
 ;                                                 ptr to f#50 is $P(x;1)
 ; Dosage                $P(G2,U)
 ; Medication Route      $P(G2,U,2)
 ; Schedule              $P(G2,U,3)
 ; Statement/Explanation ^TMP("PSOO",$J,"NVA",ILFD,"DSC",nn,0)
 ;                 
 ;      where G1=^TMP("PSOO",$J,"NVA",ILFD,0)
 ;            G2=^TMP("PSOO",$J,"NVA",ILFD,1,0)
 ;            nn & nnn = sequentual integers
 ;                 
 ; Variables  Descriptions
 ; CT         Counter of number of Herbal/OTC/Non-VA drugs for patient
 ; DFN        Patient internal number passed in
 ; DGR        Documented by's degree
 ; ILFD       Inverse Last Fill Date (FM format)
 ; JOB        $J
 ; G1,G2      Abstracted data strings from ^TMP("PSOO", - see MAIN & WRT
 ; GMT*       Variables used by HS pagination routine (GMTSUP), e.g.,
 ;               GMTSLPG=last page, GMTSTITL=title
 ; LL*        Line lengths ('^' delimited) for override reason & S/E
 ; NEWFORM    ;
 ; NL         Sequential line counter for override reasons &
 ;               statement/explanation
 ; T1,T2,T3   Integer tab stops for data display - see MAIN
 ; T4         Tab stops (#,#) for override reason display
 ; T5         Tab stops for Stmt/Expln display
 ; V          Line header verbiage describing data displayed
 ; VARY       Array of verbiage to be displayed (override reason & S/E)
 ; Y          Scratch system variable
 ;
 ; Global Variables (variables defined outside this routine)
 ; DFN, GMTSNPG, GMTSQIT
 ;                 
MAIN ; Herbal/Over-the-Counter/Non-VA Medications
 N CHAW,CLL,CT,DGR,G1,G2,GMTOP,GMX,I,ILFD,ILN,JOB,LINE,LL
 N LL5,LP,MAX,NL,OLN,PLN,T1,T2,T3,T4,T5,V,VARY,VO,X,Y
 S ILFD=0,JOB=$J,LL5="40^65"
 S T1=16,T2=58,T3=33,T4="25,10",T5="33,10"
 ; Set variables for use by report pagination routine (GMTSUP)
 S CT=0,MAX=999,GMX=0
 ; Check to see if a patient IEN is defined
 I DFN="" D CKFORM W !?8,"No patient selected" Q
 ; Check page line count and print new page and header if necessary
 D CKFORM Q:$D(GMTSQIT)
 ; Output header for report
 D:GMTSNPG!(GMX'>0) HDR Q:$D(GMTSQIT)  D CKFORM Q:$D(GMTSQIT)
 W:'GMTOP ! S GMTOP=0,GMX=1
 ; Run Pharmacy extraction
 D ^PSOHCSUM  ; DBIA 330
 ; Quit if no herbals/non-VA drugs extracted - ^TMP("PSOO") via DBIA 330
 I '$D(^TMP("PSOO",JOB,"NVA")) D CKFORM W !,?8,"No Non-VA Meds Extracted" Q
 ; Loop through ^TMP global array created by ^PSOHCSUM  ; DBIA 330
 ;   Quit if   1  Inverse Last Fill Date =0
 ;             2  Counter is not less than Max Occurrence
 ;             3  User has "up-arrowed" out of the display
 F  S ILFD=$O(^TMP("PSOO",JOB,"NVA",ILFD)) Q:+ILFD=0!(CT'<MAX)!($D(GMTSQIT))  D
 . S G1=^TMP("PSOO",JOB,"NVA",ILFD,0)
 . S G2=^TMP("PSOO",JOB,"NVA",ILFD,1,0),CT=CT+1
 . D WRT
 K ^TMP("PSOO",$J)  ;delete temporary file created via PSOHCSUM
 Q
 ;                 
WRT ; Write Data
 D CKFORM Q:$D(GMTSQIT)  ;line/pagination check - repeated ad nauseum
 D:GMTSNPG!(GMX'>0) HDR Q:$D(GMTSQIT)
 D CKFORM Q:$D(GMTSQIT)
 S V="Non-VA Med: " W !?T1-$L(V),V,$P(G1,U)
 D CKFORM Q:$D(GMTSQIT)
 S V="Status: " W !?T1-$L(V),V,$P(G1,U,2)
 ; Display discontinued date if it exists (assume discontinued status)
 S Y=$P(G1,U,7) I Y D DD^%DT W " (",$P(Y,"@"),")"  ; DBIA 10003
 S V="CPRS Order #: " W ?T2-$L(V),V,$P(G1,U,4)
 D CKFORM Q:$D(GMTSQIT)
 S V="Documented By: " W !?T1-$L(V),V,$P($P(G1,U,6),";",2)
 I $P($P(G1,U,6),";") D DEGREE W:DGR'="" ",",DGR
 S V="Documented Date: ",Y=$P(G1,U,5) D DD^%DT W ?T2-$L(V),V,Y  ; DBIA 10003
 D CKFORM Q:$D(GMTSQIT)
 S V="Clinic: "
 W !?T1-$L(V),V,$P($P(G2,U,5),";"),"-",$P($P(G2,U,5),";",2)
 S V="Start Date: ",Y=$P(G1,U,3) D DD^%DT W ?T2-$L(V),V,Y  ; DBIA 10003
 D CKFORM Q:$D(GMTSQIT)
 S V="Dispense Drug: " W !?T1-$L(V),V,$P($P(G2,U,4),";",2)
 S V="Dosage: " W ?T2-$L(V),V,$P(G2,U)
 D CKFORM Q:$D(GMTSQIT)
 S V="Med Route: " W !?T1-$L(V),V,$P(G2,U,2)
 S V="Schedule: " W ?T2-$L(V),V,$P(G2,U,3)
 S V="Statement/Explanation/Comment: ",NL=""
 D CKFORM Q:$D(GMTSQIT)
 W !
 D CKFORM Q:$D(GMTSQIT)
 W !?T3-$L(V),V
 K V M V=^TMP("PSOO",JOB,"NVA",ILFD,"DSC")
 ; Statement/Explanation verbiage
 D LINES(LL5,.V) K V D LINESOUT(T5)
 D CKFORM W !
 K VO,X,Y
 Q
 ;
LINESOUT(TN) ;WRITE LINES
 F  S NL=$O(VO(NL)) Q:NL=""!$D(GMTSQIT)  D
 . I NL=1 W ?$P(TN,","),VO(NL)
 . E  D CKFORM Q:$D(GMTSQIT)  W !?$P(T4,",",2),VO(NL)
 Q
 ;                 
LINES(LL,V) ;BREAK LINES OF AN ARRAY INTO APPROPRIATE MAX LENGTHS
 ;                 
 ; Input:
 ; LL   = line lengths, e.g., 20^30^40 where last remains default
 ; V    = input array w/ no null lines, use " " for blank line
 ;                 
 ;Output:
 ; OV   = output array of lines broken into specified maximum lengths
 ;                 
 ; This subroutine takes an array of text (V) and breaks the text into
 ;   line lengths as dictated via LL. Where the first line length (max)
 ;   of the resulting array (VO) will be (approximately, based on line
 ;   contents) $P(LL,"^",1), the second line length (max) will be
 ;   $P(LL,"^",2), etc. The last line length in LL becomes the default
 ;   maximum line length for all the remaining lines.
 ;                 
 ; This subroutine is useful if you want lines output in different
 ;   lengths.
 ;                 
 ; Variables used:
 ; CHAW   = the next piece of a line of a maximum byte length
 ; CLL    = current line length (max)
 ; I      = scratch variable
 ; ILN    = input array line number
 ; LP     = pointer indicating where in a line the last chaw taken
 ; OLN    = output (resulting) line number
 ; PLN    = previous line length (max)
 ; X      = line being parsed for a breaking point
 ;                 
 N CHAW,CLL,ILN,LP,OLN,PLN
 K VO
 S (I,ILN,X)="",OLN=1,CLL=$P(LL,U,OLN),PLN=CLL
 F  S ILN=$O(V(ILN)) Q:ILN=""  S LP=1 D
 . S I=$E($RE(V(ILN,0)))
 . S V(ILN,0)=V(ILN,0)_$S("!?."[I:"  ",",;:"[I!(I?1A):" ",1:"")
 . I V(ILN,0)=" " S:X'="" VO(OLN)=X,X="",OLN=OLN+1 S VO(OLN)=" ",OLN=OLN+1 Q
 . F  S CHAW=$E(V(ILN,0),LP,LP+CLL-$L(X)),LP=LP+$L(CHAW),X=X_CHAW Q:CHAW=""!($L(X)<CLL)  D
 .. I $L(X)<CLL S VO(OLN)=X,X="" D LINESET Q
 .. I X'[" "&($L(X)=CLL) S VO(OLN)=X_"-",X="" D LINESET Q
 .. F I=$L(X):-1:1 Q:$E(X,I)=" "!($E(X,I)="-")
 .. S VO(OLN)=$E(X,1,I),X=$E(X,I+1,999) D LINESET
 S:X'="" VO(OLN)=X
 Q
 ;                 
LINESET ; Used by LINES for setting variables
 S OLN=OLN+1,PLN=CLL,CLL=$P(LL,U,OLN) S:+CLL=0 CLL=PLN
 Q
 ;
CKFORM ; Checks to determine whether to do a form feed or not
 D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
 ;
HDR ; Prints Header
 S GMTOP=1
 I GMX'>0 D CKP^GMTSUP Q:$D(GMTSQIT)
 I 'GMTSNPG D CKP^GMTSUP Q:$D(GMTSQIT)
 Q
 ;
DEGREE ; Gets degree of 'Documented by' individual & converts to upper case
 S DGR=$$GET1^DIQ(200,$P($P(G1,U,6),";"),10.6)  ; DBIA 10060
 S DGR=$TR(DGR,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 Q
