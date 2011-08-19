SPNHPID ;SAN/WDE;Create pid segment
 ;;2.0;Spinal Cord Dysfunction;**10,24**;01/02/97
EN(SPNFDFN) ;
 ;set up vars and build pid segment called from spnhl7 & spnhl71
 ;  note that generate builds the MSH segment and puts it on top.
 Q:$G(^DPT(SPNFDFN,0))=""  ;
INI ;Build message header section
 S HLECH=","
 S HLQ="""",HLFS="^"
 D NOW^%DTC S SPNDT=$$HLDATE^HLFNC(%,"TS")
 S SPMSG=""
 S SPMSG(1)=$$EN^VAFCPID(SPNFDFN,",3,5,7,8,16,19,.315",1)
 ;S SPMSG(1)=$$EN^VAFHLPID(SPNFDFN,",3,5,7,8,16,19,.315",1)
 K SPNDT
