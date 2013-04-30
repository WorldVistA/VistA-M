DVBAPOPU ;ALB/JLU;utility routine for post inits;9/1/94
 ;;2.7;AMIE;;Apr 10, 1995
EN ;the main entry point
 D SETPURG
 Q
 ;
SETPURG ;this set up the DAYS TO KEEP 2507 HISTORY parameter.
 N PAR
 S VAR=" - Checking 2507 purge parameter"
 W !!,VAR
 D BUMPBLK^DVBAPOST,BUMPBLK^DVBAPOST,BUMP^DVBAPOST(VAR)
 K VAR
 S PAR=$$IFNPAR^DVBAUTL3
 I 'PAR DO  I 1
 .N VAR
 .S VAR="No parameter file entry exists!"
 .W *7,!!,VAR
 .D BUMPBLK^DVBAPOST,BUMPBLK^DVBAPOST,BUMP^DVBAPOST(VAR)
 .S VAR="Consult the AMIE installation manual for further details."
 .W !,VAR
 .D BUMP^DVBAPOST(VAR)
 .Q
 E  DO
 .I +$P(^DVB(396.1,PAR,0),U,11)>119 Q
 .S $P(^DVB(396.1,PAR,0),U,11)=120
 .Q
 Q
 ;
IEN6(X) ;this entry point returns the internal value of the amie exam file
 ;a null is returned if not found.
 ;
 N X1
 S X1=$O(^DVB(396.6,"B",$E(X,1,30),0))
 I X1="" D ERR1("AMIE EXAM file",X) Q X1
 I '$D(^DVB(396.6,X1,0)) D ERR2("AMIE EXAM file",X) S X1=""
 Q X1
 ;
IEN7(X) ;this entry point returns the internal value of the amie 2507 BODY SYSTEM
 ;file.
 ;a null is returned if not found.
 ;
 N X1
 S X1=$O(^DVB(396.7,"B",X,0))
 I X1="" D ERR1("2507 BODY SYSTEM file",X) Q X1
 I '$D(^DVB(396.7,X1,0)) D ERR2("2507 BODY SYSTEM file",X) S X1=""
 Q X1
 ;
ERR1(A,B) ;this entry point is to inform the user of an error in the
 ;B cross reference of the file
 ;A is the file name
 ;B is the entry number
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 S VAR="The entry "_B_" is not defined in "_A
 W !,VAR D BUMP^DVBAPOST(VAR)
 S VAR="Consult the AMIE Install Guide for details"
 W !,VAR D BUMP^DVBAPOST(VAR)
 Q
 ;
ERR2(A,B) ;this entry point is to inform the user of an error in the
 ;the zero node of the file
 ;A is the file name
 ;B is the entry number
 D BUMPBLK^DVBAPOST
 D BUMPBLK^DVBAPOST
 S VAR="The zero node of the entry "_B_" is missing in the "_A
 W !,VAR D BUMP^DVBAPOST(VAR)
 S VAR="Consult the AMIE Install Guide for details"
 W !,VAR D BUMP^DVBAPOST(VAR)
 Q
 ;
DELETE ;this entry point is used to kill the files 396.91, and 396.92
 N VAR
 K ^DVBP(396.91)
 K ^DVBP(396.92)
 S VAR(1,0)="0,0,0,1,0^Removal of data from file 396.91 and 396.92 is complete!"
 D WR^DVBAUTL4("VAR")
 Q
