XTERSUM ;ISF/RCR,RWF - Error Trap Summary Utilities ;03/25/09  11:12
 ;;8.0;KERNEL;**431**;Jul 10, 1995;Build 35
 ;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;     ; All code is accessed by alternate entry points.
 ; >D ADD^XTERSUM  ; Will gather the latest Error Traps and drop into FM
 ; >D SCAN^XTERSUM("T-30","NOW","UNDEF") - Generate Selected Error
 ;        Argument list for Start Date (def:first date on file),
 ;        Stop Date (def:last date recorded for an error),
 ;        An optional select string (def:"")
 ; Alternate Entry Point to invoke the collection from the error trap.
 ; Requires no inputs and defaults to thiry days ago, now, and no
 ;  selection criteria (everything is selected to be added).
ALL ; Include all errors in the history - Probably only run at a New Site.
 D SCAN("t-900","NOW","")
 QUIT
 ;  =========
 ; Actually, now the invocation can be shortened to D SCAN^XTERSUM("T-30")
ADD ; Include all errors in the last 30 days
 D SCAN("t-30","NOW","")
 QUIT
 ;  =========
TODAY ;  Just do Today.  Was added when there was concern for performance
 D SCAN("t","NOW","")
 QUIT
 ;  =========
 ; Call as >D REL^XTERSUM("t-1")
REL(X) ; Process from the starting time/date (in X) and NOW.
 D SCAN($G(X,"T"),"NOW","")
 QUIT
 ;  =========
 ;
 ; %D1, %D2 Optional Start (%D1) and End (%D2) Dates
 ; %TY  - Optional Type of Error to Scan For and Return
 ; Sample Call: D SCAN^XTERSUM("T-3","NOW","UNDEF")
SCAN(%D1,%D2,%TY) ; Alternative Entry Point for Demand Runs
 S %D1=$G(%D1),%D2=$G(%D2),%TY=$G(%TY)
 S:'$L(%D1) %D1=$O(^%ZTER(1,0)) S:'$L(%D2) %D2="NOW"
 N %AR,%EN,%LOC,%ZE1,%ZE2,%K,%K1,%K2,%RT,%T1,%T2,%Y1,%Y2
 N %CD,%GR,%H,%I,%J,%ST,%ZE,%ZH,%TS,%EC,%MC,%PL
 N %DUZ,%VTQUED,%XQY,%XQY0,%XUENV,%XWBTBF,%XWBTBUF,%ZTSK,%ZTQUED
 S U="^"
 S %LOC="9999"
 S %K=$$LOCATE^XTERSUM1()
 I $L(%K)  S %LOC=%K
 S %Y1=$$DEFDAT^XTERSUM1(%D1,"")
 S %Y2=$$DEFDAT^XTERSUM1(%D2,"NOW")
 S %K1=$P(%Y1,"^",2),%T1=$P(%Y1,"^",3)
 S %K2=$P(%Y2,"^",2),%T2=$P(%Y2,"^",3)
 S %K=%K1
 F  D  S %K=$O(^%ZTER(1,%K))           Q:%K>%K2    Q:%K'?1.7N
 . S %EN=0
 . F   S %EN=$O(^%ZTER(1,%K,1,%EN))     Q:%EN'?1.N  D
 . . D:$$GETER(%EN,%TY)  ; Load the new Error
 . . . N D0
 . . . D COMPILE ;      ; Set the Extracted Values into the Output Array
 . . . S D0=$$INCR(%ZE) ; Create a new record in ^%ZTER(3.077,
 . . . D:D0
 . . . . L +^%ZTER(3.077,D0):5 ; Small Lock Window, Grab, Do, Release
 . . . . D PLACERR ;      ; To build the XTERSUM Record
 . . . . L -^%ZTER(3.077,D0)
 . . . .QUIT
 . . .QUIT
 . .QUIT
 .QUIT
 ;See if need to Send summary to consolidation site.
 I $P($G(^XTV(8989.3,1,"ZTER")),U,2) D SEND^XTERSUM3
 QUIT
 ;  =========
 ; Need to get %D1 and %D2 into Fileman Standard Time/Date
 ; Then Verify the %TYpe for Identification, "" is default.
 ;  Search ^%ZTER(1,+$H,1,%EN,"GR")    ; Last Global Reference,
 ;  Search ^%ZTER(1,+$H,1,%EN,"H")     ; Date/Time Stamp of the Error,
 ;  Search ^%ZTER(1,+$H,1,%EN,"I")     ; The Current Device Used,
 ;  Search ^%ZTER(1,+$H,1,%EN,"LINE")  ; Last Line of Code
 ;  Search ^%ZTER(1,+$H,1,%EN,"ZE")    ; Error Encountered
 ;  Search ^%ZTER(1,+$H,1,%EN,"ZK")    ; System Time and Utilization Sig.
 ;  Scan for the "ZV" for %STACK to trace the activity? (Later)
 ; Inputs
 ;  %K  - Which Day's Errors to Examine, SYMBOL TABLE
 ;  D0  - %EN, points to the error for the day in %K
 ;  %SR - Search String = %TY.   Usually Null
 ; Outputs
 ;  %TS Returned as 1 = Success, and 0 = Failed to find the search string
 ;  %CD = Code with Error
 ;  %GR = Last Global Reference
 ;  %H  = Horolog date and time that the Error Occurred
 ;  %I  = Current Device Used
 ;  %J  = Job Identifier
 ;  %ST = Stack Frames
 ;  %ZE = Error Description
 ;  %ZH = System time and Utilization Signature
 ; ................
GETER(K1,%SR) ; Extract the data needed for the next Error Analysis
 N %TS
 S %CD=$G(^%ZTER(1,%K,1,K1,"LINE"))
 S %GR=$TR($G(^%ZTER(1,%K,1,K1,"GR")),"^","~")
 S %H=$G(^%ZTER(1,%K,1,K1,"H"))
 S %I=$G(^%ZTER(1,%K,1,K1,"I"))
 S %J=$G(^%ZTER(1,%K,1,K1,"J"))
 S %ZE=$G(^%ZTER(1,%K,1,K1,"ZE"))
 S %ZH=$TR($G(^%ZTER(1,%K,1,K1,"ZH")),"^",",")
 S %ST=$TR($$GETSTK(%K,K1),"^","~")
 S %TS=(%ZH_%CD[%SR) ; Separate because of String Length Problem
 S:%H %H=$$HTFM^XLFDT(%H)
 S %TS=%TS!(%GR_%H_%I_%J[%SR)
 S %TS=%TS!(%ST[%SR)
 I '%TS   K %CD,%GR,%H,%I,%J,%ST
 QUIT %TS
 ;  =========
COMPILE ; Compile the information from ^%ZTER into the Output Array, %AR
 N A,B,C1,C2,C3,C4,D
 S A=$TR($E($P(%ZE,", ",1,2),1,63),"^","~")
 ; For Cache, Strip Out the Name of the Routine and Label
 S:A["<"&($P(A,"<",2)[">") A=$P(A,">",2)_", "_$P(A,">")_">"
 Q:A=""
 ;
 S B="",D=0
 S D=$O(^%ZTER(3.077,"B",$E(A,1,30),""))
 S:D B=$G(^%ZTER(3.077,D,0))
 S C1=$P(B,"^"),C2=$P(B,"^",2),C3=$P(B,"^",3),C4=$P(B,"^",4)
 S:C2="" C2=%H
 S:C2>%H C2=%H
 S:C3="" C3=%H
 S:C3<%H C3=%H
 S:C4="" C4=$P($P(%ZE,":"),"^",2)
 S:C4="" C4="[Unknown Xecute]"
 S %AR(0)=C1_U_C2_U_C3_U_C4
 S %AR(2)=%CD ;line
 S %AR(3)=%GR ;global
 S %AR(6)=%ST ;stack
 QUIT
 ;  =========
 ; All of the parts are known at this point, now we need to find out
 ;  if they are already recorded.  Call FMT to get the error in a standard
 ;  format.
INCR(V) ; Build a New Record in ^%ZTER(3.077,
 N C,D0,RTN,T,DO,DD,DIC,X,Y
 I $G(V)=""     Q 0   ; Input Value missing
 ;
 S V=$$FMT(V) ;Get V in standard form
 S RTN=$P($G(%AR(0)),"^",4)
 S:RTN="" RTN="[No RTN]"  ;  Error is in an Execute, so no routine
 S D0=$O(^%ZTER(3.077,"B",$E(V,1,30),""))
 ;  Need a 0 in D0 to create a new entry (New Error in New Location)
 ;          in this file (3.077)
 D:'D0
 . S $P(%AR(0),U)=V
 . L +^%ZTER(3.077,0):15
 . S DIC="^%ZTER(3.077,",DIC(0)="FL",X=V
 . D FILE^DICN S D0=+Y
 . L -^%ZTER(3.077,0)
 . QUIT
 ;%ZTER placed the .01, See if need to set the rest of the data
 D:'$D(^%ZTER(3.077,D0,2))
 . S ^%ZTER(3.077,D0,0)=%AR(0)
 . S ^%ZTER(3.077,D0,1,0)="^3.07701^^"
 . S ^%ZTER(3.077,D0,2)=%AR(2)
 . S ^%ZTER(3.077,D0,3)=%AR(3)
 . S:$G(%AR(6))'="" ^%ZTER(3.077,D0,6)=%AR(6)
 . D XREF(D0)
 .QUIT
 QUIT D0
 ;
XREF(DA) ;Set other X-refs because %ZTER set the entry
 N DIK,D0
 S DIK="^%ZTER(3.077,",DIK(1)=.01 D EN1^DIK
 Q
 ;  =========
 ; First, we need to fix the various errors that are generated and make
 ;  sure that they are consistant with our standard error representations.
 ; Some additional work might be needed here to reflect the differences of
 ;  other MUMPS implementations which do not follow the DSM error format.
FMT(V) ;Format the error string
 S V=$$FMT^%ZTER(V)
 S V=$TR($E($P(V,", ",1,2),1,63),"^","~")
 ; Adjustment for Cache  - MTZ/RCR 23MAR2005
 ; Move the error description
 ;I V["<"&($P(V,"<",2)[">") S V=$P(V,">",2)_", "_$P(V,">")_">"
 Q V
 ;  =========
 ; Inputs are collected from the Error Trap
 ; Everything has been collected; Now Create the SubRecord in
 ;  ^%ZTER(3.077, But first check to see if the entity has not already
 ;  been collected.  If found;
 ;  Returns the subIEN for the entity (D1 level).
 ;  If NOT found, Return 0
PLACERR ;
 N %L,D1,KEY,T,T1,T2
 S T=$G(^%ZTER(3.077,D0,0))
 S KEY=%K_":"_%LOC ;_":"_%EN
 S D1=$O(^%ZTER(3.077,D0,1,"B",KEY,""))
 D:'D1  ; Skip if already created
 . S:'$D(^%ZTER(3.077,D0,1,0)) ^%ZTER(3.077,D0,1,0)="^3.07701^"
 . S D1=$P(^%ZTER(3.077,D0,1,0),U,3)+1
 . S $P(^%ZTER(3.077,D0,1,0),U,3,4)=D1_U_D1
 . S ^%ZTER(3.077,D0,1,"B",KEY,D1)=""
 . S ^%ZTER(3.077,D0,1,D1,0)=KEY_U_%H_U_%ZH_U_$G(%DUZ)
 . S:%CD'=$G(^%ZTER(3.077,D0,2)) ^%ZTER(3.077,D0,1,D1,1)=%CD ;line
 . S:%GR'=$G(^%ZTER(3.077,D0,3)) ^%ZTER(3.077,D0,1,D1,2)=%GR ;global
 . F  S %L=$L(%XUENV,"^")  Q:%L=3  D
 . . S %XUENV=$P(%XUENV,"^",1,3)
 . . I %L<3   S $P(%XUENV,U,3)="[?]"
 . .QUIT
 . I "^^[?]"[%XUENV  S %XUENV="^^"
 . S ^%ZTER(3.077,D0,1,D1,3)=%DUZ_U_%XQY_U_%XQY0_U_%ZTSK_U_%XUENV_U_%XWBTBF
 . S:%ST'=$G(^%ZTER(3.077,D0,6)) ^%ZTER(3.077,D0,1,D1,6)=%ST ;stack
 . S %AR(0)=$G(%AR(0))
 . S T1=$P(T,U,2,4),T2=$P($G(%AR(0)),U,2,4)
 . S:T1'=T2 $P(^%ZTER(3.077,D0,0),U,2,4)=T2
 .QUIT
 QUIT
 ;  =========
 ; Build a data structure to reflect the Stack and the code at
 ;  different stack levels of the error trap capture.  Store in
 ;  the %ST string for transfer to the record.
 ; While scanning the symbols, pick up the following symbols if
 ;  available; from symbol table;
 ;  Output
 ;  %DUZ    << DUZ     = The User Identifier
 ;  %ZTSK   << ZTSK    = The TASK Pointer being performed
 ;  %XQY    << XQY     = The OPTION being performed
 ;  %XQY0   << XQY0    = The Name of the OPTION
 ;  %ZTQUED << ZTQUEUED  = 0 means Submanager, .5 Subman in Cleanup
 ;                          other number = Task Being Performed.
 ;  %XUENV  << XUENV   = Operational Environment and CPU of the Problem
 ;     piece 1 = Global Volume
 ;     piece 2 = Routine Volume
 ;     piece 3 = CPU Used
 ; %XWBTBUF << XWBTBUF = RPC Broker Action
GETSTK(X1,X2) ; Build the Stack String
 N BF,BFD,ST,T,T0,V0
 S (V0,T0)=0,ST=""
 S (%DUZ,%VTQUED,%XQY,%XQY0,%XWBTBF,%ZTSK)="",%XUENV="^^"
 F   S V0=$O(^%ZTER(1,X1,1,X2,"ZV",V0))   Q:V0'>0   D
 . S BF=$G(^(V0,0))
 . S BFD=$G(^("D"))
 . D:BF["$STACK("
 . . I BF[",""ECODE"")"   S %EC=BFD  Q
 . . I BF[",""MCODE"")"   S %MC=BFD  Q
 . . I BF[",""PLACE"")"   D          Q
 . . . S %PL=BFD
 . . . S %PL=$P(%PL," ")_":"_$E($P(%PL," ",2),2,999)
 . . . S:%EC'="" %PL="*"_%PL
 . . . S ST=ST_">"_%PL
 . . . S:$L(ST)>240 ST=$P(ST,">",1,5)_"> ... >"_$P(ST,">",8,999)
 . . .QUIT
 . .QUIT
 . I BF="DUZ"      S %DUZ=BFD Q
 . I BF="ZTQUED"   S %ZTQUED=BFD Q
 . I BF="XQY"      S %XQY=BFD Q
 . I BF="XQY0"     S %XQY0=$P(BFD,U,2) Q
 . I BF="XUENV"    S %XUENV=$P(BFD,U,1,3) Q
 . I BF="XWBTBUF"  S %XWBTBUF=$P(BFD,U) Q
 . I BF="ZTSK"     S %ZTSK=BFD Q
 .QUIT
 QUIT "["_$E(ST,2,999)_"]"
 ;  =========
 ;
 ; Check the Cross References for the expected data
 ;  But first check to see if the entity has not already been collected.
 ;  If FOUND,       Returns the IEN for the entity.
 ;  If Not fOUND,   Return 0.
 ;  Need a 0 to create a new entry in this file (3.077)
CHKXRF(XX,K1,K2) ;
 N KEY
 S KEY=+$G(K2)
 S:XX="" XX="B"
 S K1=$G(K1)
 I K1="" Q 0 ; Bad Second Argument
 ;
 I '$D(^%ZTER(3.077,XX,K1,KEY)) S KEY=$O(^%ZTER(3.077,XX,K1,KEY))
 S:KEY="" KEY=0
 QUIT KEY
 ;  =========
