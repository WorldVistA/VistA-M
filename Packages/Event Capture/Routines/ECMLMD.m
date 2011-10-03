ECMLMD ;ALB/ESD - Multiple Dates/Multiple Procedures Driver ;20 AUG 1997 13:56
 ;;2.0; EVENT CAPTURE ;**5,15,72**;8 May 96
 ;
EN ;- Entry point for Multiple Date/Multiple Procedures Data Entry Option
 ;
 N ECCAT,ECDSSU,ECFFLG,ECL,ECLN,ECNFLG,ECPRDT,ECPROC,ECU
 ;
 ;- Ask location
 I '$$ASKLOC^ECMUTL G ENQ
 ;
 ;- Ask DSS Unit
 I $$ONEUNIT^ECMUTL(.ECDSSU),('$D(ECDSSU)) G ENQ
 ;
 ;- Ask providers (provider 1 is required, providers 2..n optional)
 D ASKPRV^ECPRVMUT("",DT,.ECU,.ECOUT) I $G(ECOUT) G ENQ
 ;
 ;- Ask procedure date(s)
 I '$$ASKPRDT^ECMUTL(+$P(ECDSSU,"^")) G ENQ
 ;
 ;- Ask category
 S ECCAT=$$ASKCAT^ECMUTL(ECL,+$P(ECDSSU,"^"))
 I $G(ECCAT)="" G ENQ
 ;
 ;- Ask procedure(s)
 D ASKPRO^ECMUTL(ECL,+$P(ECDSSU,"^"),+$P(ECCAT,"^"))
 I '$D(^TMP("ECPROC",$J)) G ENQ
 ;
 D WAIT^DICD
 ;
 ;- Call 1st ListMan screen (procedure dates/procedures)
 D EN^ECMLMP
 ;
 ;- Flag to go to 2nd ListMan screen and data in array must exist to continue
 I '$G(ECNFLG)!($G(ECNFLG)&('$D(^TMP("ECMPIDX",$J)))) G ENQ
 ;
 ;- Call 2nd ListMan screen (patients)
 D EN^ECMLMN
 ;
 ;- Flag to go to filing routine and data in array must exist to continue
 I '$G(ECFFLG)!($G(ECFFLG)&('$D(^TMP("ECMPTIDX",$J)))) G ENQ
 ;
 ;- Call filing routine
 D EN^ECMLMF
 Q
 ;
ENQ ;- clean up and exit
 K ^TMP("ECPRDT",$J),^TMP("ECPROC",$J),^TMP("ECPAT",$J)
 K ^TMP("ECMPIDX",$J),^TMP("ECMPTIDX",$J),^TMP("ECPLST",$J)
 Q
