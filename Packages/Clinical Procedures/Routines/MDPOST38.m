MDPOST38 ;ASMR/MKB - Post Installation Tasks;02 Mar 2008 ; 12/12/13 8:52pm
 ;;1.0;CLINICAL PROCEDURES;**38**;Sep 25, 2015;Build 290
 ;Per VA Directive 6402, this routine should not be modified
 ;
 ; External References -
 ;  CREIXN^DDMOD - IA # 2916
 ;
EN ; -- create ASTATUS index on OBS file #704.117
 Q:$O(^DD("IX","BB",704.117,"ASTATUS",0))  ;exists
 N VPRX,VPRY
 S VPRX("FILE")=704.117,VPRX("NAME")="ASTATUS"
 S VPRX("TYPE")="MU",VPRX("USE")="A"
 S VPRX("EXECUTION")="F",VPRX("ACTIVITY")=""
 S VPRX("SHORT DESCR")="Used to trigger MD OBSERVATION UPDATE protocol"
 S VPRX("DESCR",1)="This index invokes the MD OBSERVATION UPDATE protocol when the"
 S VPRX("DESCR",2)="status of OBS data is changed to or from verified."
 S VPRX("DESCR",3)="No actual cross-reference nodes are set or killed."
 S VPRX("SET")="D:((X1=""1"")!(X2=""1"")) PROT^MDCPROTD Q"
 S VPRX("KILL")="Q",VPRX("WHOLE KILL")="Q"
 S VPRX("VAL",1)=.09            ;Status
 D CREIXN^DDMOD(.VPRX,"",.VPRY) ;VPRY=ien^name of index
 Q
