DENTXREF ;WASH-ISC/JAH- X-refs. for files 226 and 221  13:56 ;
 ;;1.2;DENTAL;**19**;JAN 26, 1989
STATSET(STAT) ;Set logic 4 xref on field .3,station.division,file 226,A1 index
 ;In the case when station.division field is being modified xrefs on 
 ;fields 60 (released by) and .4 (provider #) (A and AC xrefs),
 ;need 2 b updated, since part of the key 2 both of those 
 ;xrefs is the station.division field.
 N DATE,PROV,REL
 S DATE=$P($P($G(^DENT(226,DA,0)),U,1),".",1)
 S PROV=$P($G(^DENT(226,DA,0)),U,3) ;           provider #
 S REL=$P($G(^DENT(226,DA,.1)),U,1) ;           released by
 I DATE'="" D
 .S ^DENT(226,"A1",STAT,DATE,DA)=""
 .; A xref is set if the data has NOT been released
 .S:$S('$D(^DENT(226,DA,.1)):1,$P(^(.1),"^",1)="":1,1:0) ^DENT(226,"A",STAT,DATE,DA)=""
 I (DATE'="")&(PROV'="") S ^DENT(226,"AC",STAT,DATE,PROV,DA)=""
 K STAT
 Q
STATKIL(STAT) ;kill logic 4 xref on field stat.div,file 226
 ;In the case when station.division field is being modified xrefs on 
 ;fields 60 (released by) and .4 (provider #) (A and AC xrefs),
 ;need 2 b updated, since part of the key 2 both of those xrefs is 
 ;the station.division field.
 N DATE,PROV,REL
 S DATE=$P($P($G(^DENT(226,DA,0)),U,1),".",1)
 S PROV=$P($G(^DENT(226,DA,0)),U,3)
 S REL=$P($G(^DENT(226,DA,.1)),U,1)
 I DATE'="" D
 .K ^DENT(226,"A1",STAT,DATE,DA)
 .K ^DENT(226,"A",STAT,DATE,DA) ;data has been released xref
 I (DATE'="")&(PROV'="") K ^DENT(226,"AC",STAT,DATE,PROV,DA)
 K STAT
 Q
STASETT(STAT) ;Set logic 4 xref on field .3,station.division,Treatment file 221
 ;In the case when station.division field is being modified xrefs on 
 ;fields 60 (released by) and .4 (provider #) (A and AC xrefs),
 ;need 2 b updated, since part of the key 2 both of those 
 ;xrefs is the station.division field.
 ;X holds station.division
 N DATE,PROV,REL
 S DATE=$P($P($G(^DENT(221,DA,0)),U,1),".",1)
 S PROV=$P($G(^DENT(221,DA,0)),U,10) ;          provider #
 S REL=$P($G(^DENT(221,DA,.1)),U,1) ;           released by
 S RELDT=$P($G(^DENT(221,DA,.1)),U,2) ;         released date
 ;
 I DATE'="" D
 .;update xref on station field
 .S ^DENT(221,"A1",STAT,DATE,DA)=""
 .S:$S(REL="":1,1:0) ^DENT(221,"A",STAT,DATE,DA)="" ;data NOT released
 ;
 I (DATE'="")&(PROV'="") D
 .;update xref on provider # field
 .S ^DENT(221,"AC1",STAT,DATE,PROV,DA)=""
 .S:$S(REL="":1,1:0) ^DENT(221,"AC",STAT,DATE,PROV,DA)=""
 ;
 ;update xref on Date Released field
 I RELDT'="" S ^DENT(221,"AG",STAT,RELDT,DA)=""
 K STAT
 Q
STAKILT(STAT) ;kill logic 4 xref on field stat.div,Treatment file 221
 ;In the case when station.division field is being modified xrefs on 
 ;fields 60 (released by) and .4 (provider #) (A and AC xrefs),
 ;need 2 b updated, since part of the key 2 both of those xrefs is 
 ;the station.division field.
 N DATE,PROV,REL
 S DATE=$P($P($G(^DENT(221,DA,0)),U,1),".",1)
 S PROV=$P($G(^DENT(221,DA,0)),U,10) ;          provider #
 S REL=$P($G(^DENT(221,DA,.1)),U,1) ;           released by
 S RELDT=$P($G(^DENT(221,DA,.1)),U,2) ;         released date
 I DATE'="" D
 .;update xref on station field
 .K ^DENT(221,"A1",STAT,DATE,DA)
 .K ^DENT(221,"A",STAT,DATE,DA)
 ;
 I (DATE'="")&(PROV'="") D
 .;update xref on provider # field and released by field
 .K ^DENT(221,"AC1",STAT,DATE,PROV,DA)
 .K ^DENT(221,"AC",STAT,DATE,PROV,DA)
 .;update xref on released by field
 .;S ^DENT(221,"AC",STAT,DATE,PROV,DA)=""
 ;update xref on Date Released field
 I RELDT'="" K ^DENT(221,"AG",STAT,RELDT,DA)
 K STAT
 Q
ASET ;Code to set "A" cross ref in file 221
 K ^DENT(221,"A",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),DA) K:$P(^DENT(221,DA,0),"^",10)]"" ^DENT(221,"AC",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),$P(^DENT(221,DA,0),"^",10),DA)
 Q
AKILL ;Code called by kill "A" cross reference of file 221
 S ^DENT(221,"A",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),DA)="" S:$P(^DENT(221,DA,0),"^",10)]"" ^DENT(221,"AC",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),$P(^DENT(221,DA,0),"^",10),DA)=""
 Q
AC1SET ;AC1 x-ref for field .4 in 221
 I $P(^DENT(221,DA,0),"^",1)'="" D
 .S ^DENT(221,"AC1",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),X,DA)="" S:$S('$D(^DENT(221,DA,.1)):1,$P(^(.1),"^")="":1,1:0) ^DENT(221,"AC",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),X,DA)=""
 Q
AC1KILL ;AC1 x-ref for field .4 in 221
 I $P(^DENT(221,DA,0),"^",1)'="" D
 .K ^DENT(221,"AC1",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),X,DA) K:$S('$D(^DENT(221,DA,.1)):1,$P(^(.1),"^")="":1,1:0) ^DENT(221,"AC",$P(^DENT(221,DA,0),"^",40),$P($P(^DENT(221,DA,0),"^"),"."),X,DA)
 Q
