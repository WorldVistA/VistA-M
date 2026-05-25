PRC247P ;RFS/MNTVBB - PRCHL GUI OPTION DECOMMISSION ; 06/10/2025 11:11am
 ;;5.1;IFCAP;**247**; Oct 20, 2000;Build 4
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 ;External References
 ; Reference to OUT^XPDMENU in ICR #1157
 ; Reference to BMES^XPDUTL in ICR #10141
 ;
 Q
 ;
DISOPT ;Mark options out of order
 N PRCLP,PRCOPT,PRCTEXT
 S (PRCLP,PRCOPT,PRCTEXT)=0
 F PRCLP=1:1 S PRCOPT=$P($TEXT(OPTLST+PRCLP),";;",2) Q:PRCOPT="$$END"  D
 .D OUT^XPDMENU(PRCOPT,"DO NOT USE!! - PRC GUI DECOM - PRC*5.1*247")
 .S PRCTEXT="The "_PRCOPT_" option has been marked out of order." D BMES^XPDUTL(PRCTEXT)
 .Q
 Q
 ;
OPTLST ;OPTION LIST
 ;;PRCHL GUI
 ;;$$END
 ;
