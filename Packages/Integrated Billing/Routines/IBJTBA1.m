IBJTBA1 ;ALB/TMK/PJH - TPJI BILL CHARGE INFO SCREEN ;Sep 30, 2014@12:07:36
 ;;2.0;INTEGRATED BILLING;**135,265,155,349,417,451,488,511,613**;21-MAR-94;Build 28
 ;Per VA Directive 6402, this routine should not be modified.
 ;
SHEOB(IBI,IBSPL,IBEOBCT,IBCTOF) ; Format EOB called from IBJTBA
 ; IBSPL = 0 if EOB represents one bill's payment
 ;       =  1 if AR had to split the EOB between multiple bills
 ; Assumes IBLN is defined and returns it with line count
 ; Assumes IBEOBDET may be defined as a flag to control detail level of print
 N X,IBPT,IBCN,IBM,IBM1,IBM2,IBTY,IBPY,IBPR,IBST,IBSTR,IBCA,IBTS,IBTA,Z,Z0
 S X="0.00"
 S IBM=$G(^IBM(361.1,IBI,0))
 S IBTY=$P(IBM,U,4),IBTY=$S(IBTY:"MEDICARE MRA",1:"NORMAL EOB")
 I IBTY'["MRA",IBSPL S IBTY="A/R SPLIT/COVERS MORE THAN 1 BILL"
 I $P(IBM,U,13)>1,$P(IBM,U,13)<5 S IBTY=IBTY_" ("_$$EXTERNAL^DILFD(361.1,.13,,$P(IBM,U,13))_")"
 S IBCN=$P(IBM,U,14),IBPY=$P(IBM,U,2)
 S:IBPY IBPY=$P($G(^DIC(36,IBPY,0)),U)
 S IBPR=$$FMTE^XLFDT($P(IBM,U,6)),IBST=$P(IBM,U,16)
 S IBST=$$EXPAND^IBTRE(361.1,.16,+IBST)
 S IBM1=$G(^IBM(361.1,IBI,1))
 ;
 S IBPT=$P(IBM1,U,2)   ; patient responsibility 1.02 file
 I $P(IBM,U,4),$D(^IBM(361.1,IBI,"ERR")) S IBPT=0  ; filing error
 ; If MRA & UB, then calculate patient responsiblity value
 I $P(IBM,U,4),$$FT^IBCEF(+$P(IBM,U,1))=3 S IBPT=$$PTRESPI^IBCECOB1(IBI)
 ;
 S IBCA=$P(IBM1,U)
 S IBM2=$G(^IBM(361.1,IBI,2)),IBTA=$P(IBM2,U,3)
 ; if no Total Allowed Amount, sum up amounts on Line Level Adjustment
 I IBTA="" S IBTA=$$ALLOWED^IBCEMU2(IBI)
 S IBTS=$P(IBM2,U,4)
 D MRA2
 S IBLN=$$SET^IBJTBA("",IBLN)
 I '$G(IBEOBDET),IBSPL D
 . S IBSTR=$$SETLN^IBJTBA("    **A/R CORRECTED PAYMENT DATA:","",1,50),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . S IBSTR=$$SETLN^IBJTBA("     TOTAL AMT PD: "_$J(+$P($G(^IBM(361.1,IBI,1)),U,1),"",2),"",1,75),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . S Z=0 F  S Z=$O(^IBM(361.1,IBI,8,Z)) Q:'Z  S Z0=$G(^(Z,0)) D
 .. S IBSTR=$$SETLN^IBJTBA($E($J("",8)_$S($P(Z0,U,3):$$BN1^PRCAFN(+$P(Z0,U,3)),1:"[suspense]"_$P(Z0,U))_$J("",25),1,25)_"  "_$J(+$P(Z0,U,2),"",2),"",1,75),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ;
 I $G(IBEOBDET) D
 . I $P($G(^IBM(361.1,IBI,0)),U,4) D  Q     ; Medicare MRA processing
 .. N VALMCNT
 .. K ^TMP("IBCECSD",$J)
 .. D GETEOB^IBCECSA6(IBI,0,,+$G(IBLN)-1)
 .. S Z=0 F  S Z=$O(^TMP("IBCECSD",$J,Z)) Q:'Z  S IBSTR=$$SETLN^IBJTBA($G(^TMP("IBCECSD",$J,Z,0)),"",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 .. K ^TMP("IBCECSD",$J)
 .. D EOBERR
 .. Q
 . ;
 . ; Normal EOB processing
 . N VALMCNT
 . K ^TMP("PRCA_EOB",$J)
 . ; IB*2*511 - do not display EEOB detail if EEOB has been "removed"
 . Q:$P($G(^IBM(361.1,IBI,102)),U)
 . D GETEOB^IBCECSA6(IBI,1)
 . S Z=0 F  S Z=$O(^TMP("PRCA_EOB",$J,IBI,Z)) Q:'Z  S IBSTR=$$SETLN^IBJTBA($G(^TMP("PRCA_EOB",$J,IBI,Z)),"",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . K ^TMP("PRCA_EOB",$J)
 . D EOBERR
 . Q
 ;
 Q
 ;
MRA2 ;
 N IBD
 S IBLN=$$SET^IBJTBA("",IBLN)
 S IBD="EOB/MRA Information"_$S($D(IBCTOF):" ("_$G(IBEOBCT)_" OF "_IBCTOF_")",1:"")
 S IBSTR=$$SETLN^IBJTBA(IBD,"",30,45),$E(IBSTR,1,2)=">>",IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ; IB*2*511 - do not display EEOB detail if EEOB has been removed
 I IBTY'["MRA",$P($G(^IBM(361.1,IBI,102)),U) D REMOVE Q
 S IBD="EOB Type: "_IBTY,IBSTR=$$SETLN^IBJTBA(IBD,"",5,59)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBD="ICN: "_IBCN,IBSTR=$$SETLN^IBJTBA(IBD,"",10,30)
 S IBD="Patient Resp Amount: "_$S('IBPT:X,1:IBPT)
 S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,44,35)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBD="Payer Name: "_IBPY,IBSTR=$$SETLN^IBJTBA(IBD,"",3,40)
 S IBD="Total Allowed Amount: "_$S('IBTA:X,1:IBTA)
 S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,43,36)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBD="EOB Date: "_IBPR,IBSTR=$$SETLN^IBJTBA(IBD,"",5,35)
 S IBD="Total Submitted Charges: "_$S('IBTS:X,1:IBTS)
 S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,40,39)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBD="Svc From Dt: "_$$DAT1^IBOUTL($P(IBM1,U,10))
 S IBSTR=$$SETLN^IBJTBA(IBD,"",2,38)
 S IBD="Svc To Dt: "_$$DAT1^IBOUTL($P(IBM1,U,11))
 S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,54,25)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=""
 I IBTY["MRA" S IBD="MRA Review Status: "_IBST,IBSTR=$$SETLN^IBJTBA(IBD,"",2,38)
 S IBD=$S('$G(IBSPL):"  ",1:"**")_"Reported Payment Amt: "_$S('IBCA:$J(X,"",2),1:$J(+IBCA,"",2))
 S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,41,37)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ;
 ; begin IB*2.0*451
 ; display Trace # and ERA # for every EOB record found. MRAs will not have an ERA #, only a Trace #
 I IBTY]"" D
 . N IBAPS,IBERAE,IBTRACE
 . S IBTRACE=$P($G(^IBM(361.1,IBI,0)),U,7)
 . I IBTRACE]"" S IBERAE=$O(^RCY(344.4,"D",IBTRACE,""))
 . S IBD="       ERA #: "_$G(IBERAE),IBSTR=$$SETLN^IBJTBA(IBD,"",1,25)
 . ; include AUTO-POST STATUS for auto-posted ERAs
 . ; *613 to fix undefined variable
 . I $G(IBERAE)]"" S IBAPS=$P($G(^RCY(344.4,IBERAE,4)),"^",2) I IBAPS]"" D
 . . S IBD=IBD_"   Auto-Post Status: "_$S(IBAPS=2:"Complete",1:"Not Complete") S IBSTR=$$SETLN^IBJTBA(IBD,"",1,80)
 . S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . S IBD="     Trace #: "_$G(IBTRACE),IBSTR=$$SETLN^IBJTBA(IBD,"",1,80) ; Trace # can be up to 50 characters long
 . S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . S IBLN=$$SET^IBJTBA("",IBLN)
 ; end IB*2.0*451
 ; 
 I IBTY["MRA",$D(^IBM(361.1,IBI,21)) D
 . S IBD=$TR($J("",35)," ","-")_"Review"_$TR($J("",38)," ","-")
 . S IBSTR=$$SETLN^IBJTBA(IBD,"",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . S (IBST,IBCN)=0 F  S IBCN=$O(^IBM(361.1,IBI,21,IBCN)) Q:'IBCN  S X=$G(^(IBCN,0)) D
 .. S IBST=0
 .. S IBD="Review Date: "_$$DAT1^IBOUTL($P(X,U))
 .. S IBSTR=$$SETLN^IBJTBA(IBD,"",1,30)
 .. S IBD="Reviewed By: "_$P($G(^VA(200,+$P(X,U,2),0)),U)
 .. S IBSTR=$$SETLN^IBJTBA(IBD,IBSTR,40,39)
 .. S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 .. S IBD=0 F  S IBD=$O(^IBM(361.1,IBI,21,IBCN,1,IBD)) Q:'IBD  S IBSTR=$$SETLN^IBJTBA($S('IBST:"Comments: ",1:"")_$G(^(IBD,0)),"",1,$S('IBST:69,1:79)),IBST=1,IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 . I 'IBST D
 .. S IBSTR=$$SETLN^IBJTBA("None","",1,10)
 .. S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ;
MOVE    ;
 ;Display details of any EEOB MOVE/COPY
 I IBTY'["MRA",$D(^IBM(361.1,IBI,101)) D
 .N IEN101,FIRST101 S IEN101=0,FIRST101=1
 .F  S IEN101=$O(^IBM(361.1,IBI,101,IEN101)) Q:'IEN101  D
 ..N IB101,IB102,IBDATE,IBUSER,IBJS,IBJS1,IBJS2,IBORIG,IBDIR
 ..S IB101=$G(^IBM(361.1,IBI,101,IEN101,0)) Q:IB101=""
 ..D GETAUDIT(IB101)
 ..I FIRST101 D
 ...S IBSTR=$$SETLN^IBJTBA("MOVE/COPY/REMOVE HISTORY","",1,78),FIRST101=0
 ...S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..S IBLN=$$SET^IBJTBA("",IBLN)
 ..S:IBDIR']"" IBDIR="Move"
 ..S IBSTR=$$SETLN^IBJTBA("Date/Time of EEOB "_IBDIR_": "_IBDATE,"",1,78)
 ..S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..S IBSTR=$$SETLN^IBJTBA(IBDIR_" of EEOB performed by: "_IBUSER,"",1,78)
 ..S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..S IBSTR=$$SETLN^IBJTBA(IBDIR_" Justification Comments: ","",1,78)
 ..S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..S IBSTR=$$SETLN^IBJTBA(IBJS,"",1,78)
 ..S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..I IBJS1]"" D
 ...S IBSTR=$$SETLN^IBJTBA(IBJS1,"",1,78)
 ...S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..I IBORIG]"" D
 ...S IBSTR=$$SETLN^IBJTBA("Original Claim Number: "_IBORIG,"",1,78)
 ...S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ..;Other claim numbers
 ..D OTHERS(IBI,IEN101)
 Q
 ;
REMOVE ; Display Removal Reason and User
 N SUB,IB101,IBDATE,IBUSER,IBJS,IBJS1,IBJS2,IBORIG,IBDIR
 S SUB=$O(^IBM(361.1,IBI,101,"A"),-1) Q:'SUB
 S IB101=$G(^IBM(361.1,IBI,101,SUB,0)) Q:IB101=""
 D GETAUDIT(IB101)
 S IBSTR=$$SETLN^IBJTBA("                 *** EEOB REMOVED ***","",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA("MOVE/COPY/REMOVE HISTORY","",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA("Date/Time EEOB Removed: "_IBDATE,"",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA("Remove of EEOB performed by: "_IBUSER,"",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA("Remove Justification Comments: ","",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA(IBJS,"",1,78)
 S IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 I IBJS1]"" S IBSTR=$$SETLN^IBJTBA(IBJS1,"",1,78),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ; display original claim
 I IBORIG]"" S IBSTR=$$SETLN^IBJTBA("Original Claim Number: "_IBORIG,"",1,78),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 ;display OTHER claim numbers
 D OTHERS(IBI,SUB)
 Q
 ;
EOBERR ; Display information about any 361.1 message storage or filing errors
 N ERRTXT,DASHES,Z
 S DASHES="---------------------------------------------------------------------"
 I '$O(^IBM(361.1,IBI,"ERR",0)) Q
 S IBSTR=$$SETLN^IBJTBA("VistA could not match all of the Line Level data received in the EEOB","",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBSTR=$$SETLN^IBJTBA("(835 Record 40) to the claim in VistA.","",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 S IBLN=$$SET^IBJTBA("",IBLN)
 S Z=0 F  S Z=$O(^IBM(361.1,IBI,"ERR",Z)) Q:'Z  D
 .S ERRTXT=$G(^IBM(361.1,IBI,"ERR",Z,0))
 .I ERRTXT["##RAW DATA" S ERRTXT=DASHES
 .S IBSTR=$$SETLN^IBJTBA(ERRTXT,"",1,79),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 Q
 ;
GETAUDIT(IB101) ; retrieve audit data
 ;   IB101 - string of data at the MOVE/COPY/REMOVE HISTORY multiple (361.1,101)
 S IBDATE=$$EXTERNAL^DILFD(361.1101,.01,,$P(IB101,U,1))
 S IBUSER=$$EXTERNAL^DILFD(361.1101,.02,,$P(IB101,U,2))
 S IBJS=$E($P(IB101,U,3),1,78),IBJS1=$E($P(IB101,U,3),79,100)
 S IBDIR=$$EXTERNAL^DILFD(361.1101,.05,,$P(IB101,U,5))
 S IBORIG=$$EXTERNAL^DILFD(361.1101,.04,,$P(IB101,U,4))
 Q
 ;
OTHERS(IBI,IEN101) ; get other claim(s)
 ; IBI - ien for entry in 361.1
 ; IEN101 - sub-ien for entry in 361.1,101 multiple
 N SUB,IBOTH,OTEXT
 S SUB=0,OTEXT=""
 F  S SUB=$O(^IBM(361.1,IBI,101,IEN101,1,SUB)) Q:'SUB  D
 . S IBOTH=$P($G(^IBM(361.1,IBI,101,IEN101,1,SUB,0)),U) Q:'IBOTH
 . S IBOTH=$$EXTERNAL^DILFD(361.11016,.01,,IBOTH) Q:IBOTH=""
 . S OTEXT=OTEXT_","_IBOTH
 S OTEXT=$P(OTEXT,",",2,99)
 I OTEXT]"" S IBSTR=$$SETLN^IBJTBA("Other Claims: "_OTEXT,"",1,78),IBLN=$$SET^IBJTBA(IBSTR,IBLN)
 Q
 ;
