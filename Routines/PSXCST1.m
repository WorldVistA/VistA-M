PSXCST1 ;BIR/JMB-Date Range Compile/Recompile Cost Data-CONTINUED ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
RECOM1 ;Gets last month that is compiled with monthly data. (3 months ago)
 ;E.g. Today=11/3/94, 8/94 is last date to be compiled with monthly data.
 S PSXMON=$E(DT,4,5),PSXMON=$P("10^11^12^01^02^03^04^05^06^07^08^09","^",PSXMON) S PSXYR=$S(+PSXMON>9:($E(DT,1,3)-1),1:$E(DT,1,3)),PSXCUT=PSXYR_PSXMON_"00"
 ;If PSXBEG's yr & mon > 2 mons ago, set PSXBEG to 3 months ago & queue
 ;monthly data. Then set 2 months ago to PSXEND & compile daily data.
 I $E(PSXBEG,1,5)<$E(PSXCUT,1,5) S PSXBDT=PSXBEG,PSXEDT=$S($E(PSXEND,1,5)<$E(PSXCUT,1,5):PSXEND,1:PSXCUT),PSXCOM=0 D QUE^PSXCST Q:$G(PSXERR)  G:PSXEND=PSXEDT END^PSXCSUTL D  Q:$G(PSXERR)
 .S PSXBDT=$S($E(PSXCUT,4,5)=12:$E(PSXCUT,1,3)+1,1:$E(PSXCUT,1,3))_$P("02^03^04^05^06^07^08^09^10^11^12^01","^",$E(PSXCUT,4,5))_"01",PSXEDT=PSXEND,PSXCOM=2 D QUE^PSXCST
 ;If PSXBEG's yr & mon are 3 months ago, send PSXBEG's month for monthly
 ;compile. If PSXEND is not same yr & mon as PSXBEG, send 2 months ago to
 ;PSXEND for daily compile.
 I $E(PSXBEG,1,5)=$E(PSXCUT,1,5) S (PSXBDT,PSXEDT)=PSXCUT,PSXCOM=0 D QUE^PSXCST  Q:$G(PSXERR)  D
 .Q:$E(PSXBEG,1,5)=$E(PSXEND,1,5)
 .S PSXNEXT=$S($E(PSXCUT,4,5)=12:$E(PSXCUT,1,3)+1,1:$E(PSXCUT,1,3))_$P("02^03^04^05^06^07^08^09^10^11^12^01","^",$E(PSXCUT,4,5))
 .S PSXBDT=PSXNEXT_"00",PSXEDT=PSXEND,PSXCOM=2 D QUE^PSXCST Q:$G(PSXERR) 
 ;If PSXBEG is before monthly data should be compiled, send PSXBEG to
 ;PSXEND for daily compilation.
 I $E(PSXBEG,1,5)>$E(PSXCUT,1,5) S PSXBDT=PSXBEG,PSXEDT=PSXEND,PSXCOM=2 D QUE^PSXCST Q:$G(PSXERR)
 G END^PSXCSUTL
