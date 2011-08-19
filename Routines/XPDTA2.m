XPDTA2 ;SFISC/RWF -  Build Actions for Kernel Files Cont. ;08/09/2001  12:36
 ;;8.0;KERNEL;**201,498**;Jul 10, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;^XTMP("XPDT",XPDA,"KRN",XPDFILE,DA) is the global root
 ;DA=ien in ^XTMP,XPDNM=package name, XPDA=package ien in ^XPD(9.6,
 ;
PAR1E1 ;PARAMETER file 8989.51: entry post
 N XP,XP1,XP2,XP3,XP4,VP,PN,PT,ROOT
 S ROOT=$NA(^XTMP("XPDT",XPDA,"KRN"))
 D PAR51(DA) ;Handle the entry from 8989.51
 S PT=$S($E($G(^XTV(8989.51,DA,1)))="P":$P(^(1),U,2),1:"") ;Data Type & Value - check if pointer in for loop
 S:PT]"" PT=$S(PT:$$GR^XPDTA(PT),1:"") ;PT=file # of pointed to file from parm def.
 ;Now find any entrys in 8989.5 to transport, because we point to them
 S XP=0,XP3=$P(^XPD(9.6,XPDA,0),U,2),VP=XP3_";DIC(9.4,",PN=$$PT^XPDTA("^DIC(9.4)",XP3)
 Q:'XP3  ;No package file link
 F  S XP=$O(^XTV(8989.5,"AC",DA,VP,XP)),XP1=0 Q:'XP  D  ;Instance
 . F  S XP1=$O(^XTV(8989.5,"AC",DA,VP,XP,XP1)) Q:'XP1  D  ;entry
 . . M ^XTMP("XPDT",XPDA,"KRN",8989.5,XP1)=^XTV(8989.5,XP1)
 . . S XP3=^XTV(8989.5,XP1,0),XP4=$G(^(1)) ;param def.
 . . S $P(@ROOT@(8989.5,XP1,0),U,2)=$$PT^XPDTA("^XTV(8989.51)",$P(XP3,U,2))
 . . I PT]"",XP4>0 S $P(@ROOT@(8989.5,XP1,1),U)=$$PT^XPDTA(PT,XP4) ;Data Type pointer - resolve
 . . Q  ;Will redo the ENT at other end.
 Q
 ;
PAR51(DA) ;Fix one 8989.51 entry in transport global
 ;Called from both PAR1E1 and PAR2E1
 N XP,XP1,XP2,XP3,VP,PN,ROOT
 S ROOT=$NA(^XTMP("XPDT",XPDA,"KRN"))
 ;Don't bring X-ref
 K @ROOT@(8989.51,DA,30,"B"),^("AG")
 S XP=0
 ;Entries in the file will be maintained by Toolkit patches.
 Q
 ;
PAR2E1 ;PARAMETER file 8989.52 entry post
 N XP1,XP2,XP3,ROOT
 S ROOT=$NA(^XTMP("XPDT",XPDA,"KRN"))
 ;Resolve USE INSTANCE OF
 S XP2=$P(^XTV(8989.52,DA,0),U,4),XP3="" I XP2 S XP3=$$PT^XPDTA($NA(^XTV(8989.51)),XP2)
 I $L(XP3) S $P(@ROOT@(8989.52,DA,0),U,4)=XP3
 ;Resolve PARAMETERS
 S XP1=0 K ^XTMP("XPDT",XPDA,"KRN",8989.52,DA,10,"B") ;Drop X-ref
 F  S XP1=$O(^XTV(8989.52,DA,10,XP1)),XP3="" Q:'XP1  D
 . S XP2=$P(^XTV(8989.52,DA,10,XP1,0),U,2)
 . I XP2 S XP3=$$PT^XPDTA($NA(^XTV(8989.51)),XP2)
 . I '$L(XP3) K @ROOT@(8989.52,DA,10,XP1)
 . S $P(^XTMP("XPDT",XPDA,"KRN",8989.52,DA,10,XP1,0),U,2)=XP3
 . ;Now to move the entries this points to.
 . I '$D(@ROOT@(8989.51,XP2)) M @ROOT@(8989.51,XP2)=^XTV(8989.51,XP2) D PAR51(XP2)
 . Q
 Q 
