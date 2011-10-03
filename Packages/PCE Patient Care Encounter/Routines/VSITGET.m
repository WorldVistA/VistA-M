VSITGET ;ISD/RJP - Visit Return Search and Match Logic of a Visit ;6/20/96
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**76**;Aug 12, 1996
 ; Patch PX*1*76 changes the 2nd line of all VSIT* routines to reflect
 ; the incorporation of the module into PCE.  For historical reference,
 ; the old (VISIT TRACKING) 2nd line is included below to reference VSIT
 ; patches.
 ;
 ;;2.0;VISIT TRACKING;;Aug 12, 1996;
 ;
 Q  ; - not an entry point
 ;
LST(VDT,DFN,PRAM,VSIT,VSITGET) ; - search for matches
 ; - called by ^VSIT and Supported Direct Call
 ;
 ; - VSIT & VSITGET are passed by reference
 ; - pass {VDT/VSIT("VDT")}  = <FM date [and time]>
 ;        {DFN/VSIT("PAT")}  = <patient pointer>
 ;        [PRAM/VSIT(0)]     = <param string>
 ;        [VSIT("xxx")]      = <used in matching logic if VSIT(0)["M">
 ;                             [<fld-value>[^...]] for multiple values
 ;        .VSITGET           = <array passed by reference>
 ; - rtns .VSITGET           = <number of matches>
 ;        .VSITGET(<ien>)    = <sorted by visit date>
 ;                            (array of selected visits)
 K VSITGET
 S VSITGET=0
 ;
 S:$G(VDT)]"" VSIT("VDT")=VDT
 S:$G(DFN) VSIT("PAT")=+DFN
 S:$G(PRAM)]"" VSIT(0)=PRAM
 I '+$G(VSIT("VDT"))!('+$G(VSIT("PAT"))) G QUIT
 ;
 I '($D(^TMP("VSITDD",$J))\10) D FLD^VSITFLD
 N NOD,IEN,VSITDAT,VSITBEG,VSITEND,VSITSORT,VSITIPV
 ;
 D:$G(VSIT("SVC"))="" CKIP(VSIT("VDT"),VSIT("PAT"))
 ;
 D RANGE
 S VSITDAT=VSITBEG
 F  S VSITDAT=$O(^AUPNVSIT("AA",+VSIT("PAT"),VSITDAT)) Q:VSITDAT'>0!(VSITDAT>VSITEND)  D
 . D:$G(VSIT("SVC"))="" CKIP(9999999-$P(VSITDAT,"."),VSIT("PAT"))
 . S IEN=0
 . F  S IEN=$O(^AUPNVSIT("AA",+VSIT("PAT"),VSITDAT,IEN)) Q:IEN'>0  D
 .. S NOD=$$MATCH(IEN)
 .. S:NOD]"" VSITSORT($P(NOD,"^"),$P(NOD,"^",2),IEN)=IEN_"|"_NOD
 .. K:$D(VSITIPV(IEN)) VSITIPV(IEN)
 ;
 S VSITIPV=0 F  S VSITIPV=$O(VSITIPV(VSITIPV)) Q:VSITIPV=""  D
 . S IEN=VSITIPV
 . S NOD=$$MATCH(IEN)
 . S:NOD]"" VSITSORT($P(NOD,"^"),$P(NOD,"^",2),IEN)=IEN_"|"_NOD
 ;
 ;Put into VSITGET in sorted order
 S VSITGET=0
 S NOD=$Q(VSITSORT(0,0,0))
 G:NOD="" QUIT ;no visit found
 ;Set first one
 S VSITGET=VSITGET+1
 S VSITGET(VSITGET)=@NOD
 ;Set rest
 I NOD]"" F  S NOD=$Q(@NOD) Q:NOD=""  S VSITGET=VSITGET+1,VSITGET(VSITGET)=@NOD
 ;
QUIT ; - exit
 ;
 Q
 ;
CKIP(DATE,PAT) ; - check to see if inpatient over date range but admitted earlier
 ;
 N IPM,IPV
 S IPM=$$IP^VSITCK1(DATE,PAT)
 I +IPM,'$P($G(^DIC(150.9,1,0)),"^",5) D
 . S IPV=+$P($G(^DGPM(IPM,0)),"^",27)
 . S:'$D(VSITIPV(IPV)) VSITIPV(IPV)=""
 Q
 ;
MATCH(IEN) ; - screen matches using visit array
 ;
 ; - pass IEN = <internal entry number of visit node>
 ; - rtns NOD = <zero node of ien record or null>
 ;
 Q:'IEN ""
 S NOD=$G(^AUPNVSIT(IEN,0))
 Q:+$P(NOD,"^",11) ""
 I $G(VSIT(0))["M" D
 . N X,VSITI,VSITM
 . F X="DSS","LOC","INS","TYP" D:$G(VSIT(X))]""  Q:NOD=""
 .. S VSITM=0
 .. F VSITI=1:1:$L(VSIT(X),"^") S:$P(VSIT(X),"^",VSITI)=$P(NOD,"^",$P(^TMP("VSITDD",$J,X),";",4)) VSITM=1
 .. S:'VSITM NOD=""
 Q NOD
 ;
RANGE ; - date range
 ;
 ; - pass VSIT("VDT") = <FM date [and time]>
 ;        VSIT(0)     = <param string> ; will assume D1 if not specified
 ; - rtns VSITBEG     = 9's complement of FM search start date
 ;        VSITEND     = 9's complement of FM search end date
 ;
 N X,X1,X2
 S X1=+VSIT("VDT")
 S X2=$F($G(VSIT(0)),"D")
 I X2>1 S X2=$E($G(VSIT(0)),$F($G(VSIT(0)),"D"),99),X2=$S(X2>0:-(X2-1),1:0)
 E  S X2=0
 D C^%DTC
 S VSITBEG=9999999-$P(+VSIT("VDT"),".")+$S(+$F($G(VSIT(0)),"D0"):"."_$P(+VSIT("VDT"),".",2)-.0000001,1:"-.0000001")
 S VSITEND=9999999-$P(+X,".")_$S(+$F($G(VSIT(0)),"D0"):"."_$P(+VSIT("VDT"),".",2)+.0000001,1:".999999")
 Q
