IBDFRPC1 ;ALB/AAS - Return list of selections ; 2-JAN-96
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**25**;APR 24, 1997
 ;
 ; -- used by AICS Data Entry Systems, IBDFDE2, IBDFDE3, IBDFDE4
 ;
OBJLST(RESULT,IBDF) ; -- Procedure
 ; -- Broker call to return any specified selection list, handprint field or multiple choice field
 ;    rpc  := IBD GET ONE INPUT OBJECT
 ;
 ; -- input   RESULT         := see output
 ;            IBDF("PI")     := package interface name or pointer
 ;            IBDF("TYPE")   := type of input object
 ;            IBDF("IEN")    := internal entry number of object
 ;            IBDF("DFN")    := pointer to patient (2) (required for patient active problems only)
 ;            IBDF("CLINIC") := pointer to hospital location (44) (required for provider list only)
 ;            IBDF("KILL")   := 1 to kill results array prior to setting (Default)  (optional)
 ;
 ; -- Output  RESULT (called by reference)
 ;    new for version 3.0 RESULT may be a closed global, i.e. ^tmp($j)
 ;      and the data will be returned in ^tmp($j,n)
 ;    For Lists:
 ;            RESULT(0)      := number of entries^type of input object (LIST)^qualifier;;selection rule[::qualifier;;selection rule)^no scannable bubbles(1 if not scannable)
 ;            RESULTS(N) $P1 := Display text
 ;                       $P2 := Display code
 ;                       $P3 := input value (value to return)
 ;                       $P4 := input transform 
 ;                       $P5 := optional caption
 ;                       $P6 := optional Term pointer
 ;                       $P7 := Selectable
 ;
 ;    For Hand Print Fields
 ;            RESULT(0) := 1^type of object (HP)^label^vitals type
 ;            RESULT(1) := Text from form^print format in 359.1^MAX lenght^units^vitals Type^PCE DIM Units
 ;
 ;   For Multiple Choice fields
 ;            RESULT(0) := count of choices^type (MC)^display text^selection rule
 ;            RESULT(n) := display text^label^value to return^qualifier^^^selectable (1)
 ;
 N IBQUIT,LIST,CLINIC,CL1,PI,PKG,PKG1,DYN,ARRY,VALUE
 S (IBQUIT,LIST)=0
 ;
 I $E($G(RESULT),1)="^" S ARRY=RESULT
 E  S ARRY="RESULT"
 I $G(IBDF("KILL"))="" S IBDF("KILL")=1
 K:IBDF("KILL") @ARRY
 ;
 S @ARRY@(0)="No package Interface found, 1"
 ; -- set pkg = ien of pkg interface from either b or e x-ref
 S PKG=$G(IBDF("PI"))
 I +PKG'=PKG,PKG'="" S PKG1=+$O(^IBE(357.6,"B",$E(PKG,1,30),0)) I 'PKG1 S PKG1=+$O(^IBE(357.6,"E",$E(PKG,1,40),0))
 I $G(PKG1),'PKG S IBDF("PI")=PKG1
 G:'$G(IBDF("PI")) OBJLSTQ
 G:$G(^IBE(357.6,+IBDF("PI"),0))="" OBJLSTQ
 ;
 I $G(IBDF("TYPE"))="" D
 .S ITYP=$P($G(^IBE(357.6,+IBDF("PI"),0)),"^")
 .S IBDF("TYPE")=$S(ITYP=3:"LIST",ITYP=4:"MC",ITYP=5:"HP",1:"")
 I $G(IBDF("TYPE"))="" S @ARRY@(0)="Object Type not determined" G OBJLSTQ
 I "^LIST^MC^HP^"'[("^"_IBDF("TYPE")_"^") S @ARRY@(0)="Object type Unknown" G OBJLSTQ
 ;
 ;S FRM=$G(IBDF("FRM"))
 ;I +FRM'=FRM,FRM'="" S FRM=+$O(^IBE(357,"B",FRM,0))
 ;I 'FRM S FRM=$$DEFAULT^IBDFRPC S:FRM @ARRY@(0)="Using default form",IBDF("FRM")=FRM G:'FRM OBJLSTQ
 ;
 ; -- if type is selection list
 I IBDF("TYPE")="LIST" D  G OBJLSTQ
 .S DYN=$P(^IBE(357.6,IBDF("PI"),0),"^",14)
 .I 'DYN D SEL^IBDFRPC2(.RESULT,.IBDF)
 .I DYN D DYN^IBDFRPC2(.RESULT,.IBDF)
 ;
 ; -- if type is multiple choice
 I IBDF("TYPE")="MC" D MC G OBJLSTQ
 ;
 ; -- If type is Hand Print
 I IBDF("TYPE")="HP" D HP G OBJLSTQ
 ;
 S @ARRY@(0)="Processing did not occur"
 ;
OBJLSTQ Q
 ;
MC ; -- returns list from multiple choice fields
 N X,DTEXT,SRULE,CHOICE,CH,CTEXT,CHLBL,CHID,CHQLF,CNT
 S @ARRY@(0)="Multiple Choice Field not found"
 G:'$G(IBDF("IEN")) MCQ
 S X=$G(^IBE(357.93,IBDF("IEN"),0)) G:X="" MCQ
 ;
 S DTEXT=$P(X,"^",2),SRULE=$P(X,"^",9)
 ;
 S (CHOICE,CNT)=0
 F  S CHOICE=$O(^IBE(357.93,IBDF("IEN"),1,CHOICE)) Q:'CHOICE  D
 .S CH=$G(^IBE(357.93,IBDF("IEN"),1,CHOICE,0)) Q:CH=""
 .S CTEXT=$P(CH,"^"),CHLBL=$P(CH,"^",5),CHID=$P(CH,"^",8)
 .S CHQLF=$P(CH,"^",9),VALUE=$P($G(^IBD(357.98,+$G(CHQLF),0)),"^")
 .S CNT=CNT+1
 .S @ARRY@(CNT)=CTEXT_"^"_CHLBL_"^"_VALUE_"^"_CHQLF_"^^^1"
 .Q
 S @ARRY@(0)=CNT_"^MC^"_DTEXT_"^"_SRULE
MCQ Q
 ;
HP ; -- returns information on hand print field
 N X,HNODE,HTEXT,HTYPE,HLEN,HPIC,HMEAS,VTYPE,VUNIT
 S @ARRY@(0)="Hand Print field not found"
 G:'$G(IBDF("IEN")) HPQ
 S HNODE=$G(^IBE(359.94,IBDF("IEN"),0))
 G:$G(HNODE)="" HPQ
 S HTEXT=$P(HNODE,"^",2)
 S HTYPE=$G(^IBE(359.1,+$P(HNODE,"^",10),0))
 S HLEN=$P(HTYPE,"^",2),HPIC=$$FRMT^IBDF2F(HTYPE,$G(IBAPPT)),HMEAS=$P(HTYPE,"^",11),VTYPE=$P(HTYPE,"^",12),VUNIT=$P(HTYPE,"^",13)
 S @ARRY@(1)=HTEXT_"^"_HPIC_"^"_HLEN_"^"_HMEAS_"^"_VTYPE_"^"_VUNIT
 S @ARRY@(0)="1^HP^"_HTEXT_"^0"
 ;
HPQ Q
 ;
3 ; -- return lists of providers/cpts/diagnosis from form
 ;    format as in 2
 Q
 ;
4 ; -- provide list of other input items/and parameters
 Q
 ;
TESTD ; -- test dynamic list
 S IBDF("PI")=61
 S IBDF("IEN")=1729
 S IBDF("TYPE")="LIST"
 S IBDF("CLINIC")=300
 S IBDF("DFN")=1
 D OBJLST(.TEST,.IBDF)
 X "ZW TEST"
 Q
 ;
TESTL ; -- test list
 K TEST
 S IBDF("PI")=7
 S IBDF("IEN")=488
 S IBDF("TYPE")="LIST"
 D OBJLST("^TMP($J,""TESTL"")",.IBDF)
 X "ZW TEST"
 Q
 ;
TESTM ; -- test Multiple choice
 K TEST
 S IBDF("PI")=7
 S IBDF("TYPE")="MC"
 S IBDF("IEN")=161
 D OBJLST("^TMP($J,""TESTM"")",.IBDF)
 X "ZW TEST"
 Q
TESTH ; -- test Hand Print
 K TEST
 S IBDF("PI")=95
 S IBDF("TYPE")="HP"
 S IBDF("IEN")=352
 D OBJLST(.TEST,.IBDF)
 X "ZW TEST"
 Q
