DG53789P ;ALB/MAF - INCONSISTANCY CHECKER UPDATE ROUTINE; 13 December 1996
 ;;5.3;Registration;**789**;JUL 28, 2008;Build 7
 ;
 ; This routine checks inconsistency field (#6) Use for Z07 to make sure it is set correctly for all the entries in file 38.6.  If the value is not set to the directive value, this routine will reset the value and notify the user of the change. 
 ;
EN ; check values for field #6 in file 38.6
 N DA,DIE,DR,DIC,DGI,DGJ,DGX,X,Y,ENTRY,VALUE,VALDA,VAL6,VALNODE,DGFLAG
 S DGFLAG=0
 D BMES^XPDUTL(">>>Checking all entries in file 38.6 for correct values in field #6 Use for Z07...")
 F DGI=1:1 S DGX=$P($T(DATA+DGI),";;",2) Q:DGX="QUIT"  S DGJ=0 F  S DGJ=DGJ+1 S VALUE=$P(DGX,"^",DGJ) Q:VALUE=""  S VALDA=$P(VALUE,";",1),VAL6=$P(VALUE,";",2) I $D(^DGIN(38.6,VALDA,0)) D
 . S VALNODE=$G(^DGIN(38.6,VALDA,0))
 . I $P(VALNODE,"^",6)=VAL6 Q
 . S DIE="^DGIN(38.6,"
 . S DA=VALDA,DR="6////^S X=VAL6"
 . D ^DIE
 . S ENTRY=$J("Entry "_VALDA_" : ",13)
 . D MES^XPDUTL(ENTRY_$P(VALNODE,"^",1)_" set from "_$S($P(VALNODE,"^",6)=1:"YES",$P(VALNODE,"^",6)=0:"NO",1:"NULL")_" to "_$S(VAL6=1:"YES",1:"NO"))
 . I DGFLAG=0 S DGFLAG=1
 . Q
 I 'DGFLAG D MES^XPDUTL("    All values agree with those in VHA Directive 2008-031 ... nothing changed.")
 ;
 ;
DATA ; lines to stuff in values (field////value)
 ;;1;0^2;0^3;0^4;1^5;0^6;0^7;1^8;0^9;1^10;0^11;1^12;0^13;1^14;0^15;1^16;1^17;0^18;0^19;1^20;0^21;0^22;0^23;0^24;1^25;0^26;0^27;0^28;0^29;1^30;1^31;1^32;0^33;0^34;1^35;0^36;0^37;0^38;0^39;0^40;0^41;0^42;0^43;0^44;0^45;0^46;0^47;0^48;0
 ;;49;0^50;0^51;0^52;0^53;0^54;0^55;0^56;0^57;0^58;0^59;0^60;1^61;0^62;0^63;0^64;0^65;0^66;0^67;0^68;0^69;0^70;0^71;0^72;0^73;0^74;0^75;0^76;0^77;0^78;0^79;0^80;0^81;0^82;0^83;1^84;0^85;1^86;1^87;0^99;0^301;1^303;1^304;1^306;0^307;0
 ;;308;1^309;1^310;1^312;1^401;1^402;1^403;1^406;1^407;1^409;0^411;1^501;1^502;1^503;1^504;1^505;1^506;1^507;1^508;1^509;1^510;1^511;1^516;1^517;1^701;1^702;1^703;1^704;1^705;1^706;1^707;1^708;1^709;1^710;1^711;1^712;1^713;1^714;1
 ;;715;1^716;1^717;1^718;0^719;1^720;1^723;1^724;1^725;1^726;1
 ;;QUIT
