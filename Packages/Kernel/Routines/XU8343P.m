XU8343P ;BPOIFO/DW - Post-init for XU*8*343 ; 14 April 2004
 ;;8.0;KERNEL;**343**; Jul 10, 1995;
 ;
 Q
 ;
POST ;Post-init functions
 ;
 N XUMSG
 ;Make sure the user has a DUZ to receive MailMan messages
 S XUMSG="Please make sure that you have a valid DUZ, so that you will receive the reports via MailMan."
 I $G(DUZ)<1 D  Q
 . D BMES^XPDUTL(.XUMSG)
 I $P($G(^VA(200,DUZ,0)),U)="" D  Q
 . D BMES^XPDUTL(.XUMSG)
 K XUMSG
 ;
 ;Update input transforms and field description for field #.01
 D ITXDES
 D NEWXR^XU8343Q
 ;
 ;Recompile input templates
 D RECOMP
 ;
 ;Update triggered fields
 D TRIG
 ;
 ;Convert existing names
 D POST^XU8343S
 ;
 Q
 ;
ITXDES ;Set input transforms and field descriptions
 D BMES^XPDUTL("Setting field descriptions and input transforms")
 ;
 S $P(^DD(200,.01,0),U,5,99)="K XLFNC K:($L(X,"","")'=2) X I $D(X) S XLFNC=X,(X,XLFNC)=$$FORMAT^XLFNAME7(.XLFNC,3,35,,,,,2) K:$L(X)>35!($L(X)<3)!($L(X,"","")'=2)!(X'?1.E1"",""1.E) X,XLFNC K:'$G(XUITNAME) XLFNC"
 ;
 K ^DD(200,.01,21)
 S ^DD(200,.01,21,0)="^^6^6^3040421^"
 S ^DD(200,.01,21,1,0)="Enter only data that is actually part of the person's name. Do not"
 S ^DD(200,.01,21,2,0)="include extra titles, identification, flags, local information, etc."
 S ^DD(200,.01,21,3,0)="Enter the person's name in 'LAST,FIRST MIDDLE SUFFIX' format."
 S ^DD(200,.01,21,4,0)="This value must be 3-35 characters in length and may contain only"
 S ^DD(200,.01,21,5,0)="uppercase alpha characters, spaces, apostrophes, hyphens and one comma."
 S ^DD(200,.01,21,6,0)="All other characters and parenthetical text will be removed."
 Q
 ;
RECOMP ;Recompile input templates
 D BMES^XPDUTL("Recompiling templates...")
 ;
 N XUFLD
 S XUFLD(200,.01)=""
 D DIEZ^DIKCUTL3(200,.XUFLD)
 ;
 Q
 ;
TRIG ;Update triggered fields
 D BMES^XPDUTL("Updating trigger field definitions...")
 ;
 N XUFLD,XUOUT
 S XUFLD(200,.01)=""
 D TRIG^DICR(.XUFLD,.XUOUT)
 ;
 N XUFL,XUFD
 S XUFL=0 F  S XUFL=$O(XUOUT(XUFL)) Q:'XUFL  D
 . S XUFD=0 F  S XUFD=$O(XUOUT(XUFL,XUFD)) Q:'XUFD  D
 .. D MES^XPDUTL("         Field #"_XUFD_" of file #"_XUFL_" updated.")
 ;
 Q
 ;
