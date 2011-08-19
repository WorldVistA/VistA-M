MCPRE07 ;HIRMFO/DAD-KILL RECORDS WITH NO ZERO NODES ;8/2/96  11:00
 ;;2.3;Medicine;;09/13/1996
 ;
 N MCD0,MCDATA,MCFILE,MCOFFSET
 S MCDATA(1)=""
 S MCDATA(2)="Searching the Medicine files for bad records, (missing"
 S MCDATA(3)="zero nodes).  If found, these records will be killed."
 D MES^XPDUTL(.MCDATA)
 ;
 F MCOFFSET=1:1 S MCFILE=$P($T(FILE+MCOFFSET),";",3) Q:MCFILE'>0  D
 . S MCD0=0
 . F  S MCD0=$O(^MCAR(MCFILE,MCD0)) Q:MCD0'>0  D
 .. I $G(^MCAR(MCFILE,MCD0,0))="" K ^MCAR(MCFILE,MCD0)
 .. Q
 . Q
 Q
FILE ;;File#
 ;;690
 ;;691
 ;;691.1
 ;;691.5
 ;;691.6
 ;;691.7
 ;;691.8
 ;;691.9
 ;;692
 ;;694
 ;;694.5
 ;;698
 ;;698.1
 ;;698.2
 ;;698.3
 ;;699
 ;;699.5
 ;;700
 ;;701
