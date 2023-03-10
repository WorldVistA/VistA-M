RAIPR175 ;HISC/GJC-preinit 175 ; Jan 19, 2021@15:45:32
 ;;5.0;Radiology/Nuclear Medicine;**175**;Mar 16, 1998;Build 2
 ;
 ;Routine              File     IA          Type
 ;----------------------------------------------
 ;$$FIND1^DIC()                 2051         (S)
 ;BMES^XPDUTL                   10141        (S)
 ;$$DELETE^XPDMENU()            1157         (S)
 ;DELIX^DDMOD()                 2916         (S)
 ;
EN ;entry point to remove ITEMS from the RA ORDER menu
 ; first, get the IEN for the RA ORDER menu
 N RAERR,RAITEM,RAMENU,RAX S RAX="RA ORDER"
 S RAMENU=$$FIND1(RAX)
 ; not found, record incident and exit
 I RAMENU=-1 D  Q
 .D BMES^XPDUTL("Exiting: the 'RA ORDER' menu was not found!")
 .Q
 ;save off name
 S RAMENU=RAX
 ;
 ;Find the specific options listed in the FOR loop.
 ;If success, save the IEN of those option names as
 ;a subscript in the RAITEM() array.
 ;
 F RAX="RA ORDERLOG","RA ORDERPENDING","RA ORDERLOGLOC" D
 .N Y S Y=$$FIND1(RAX)
 .I Y=-1 D BMES^XPDUTL("Option: "_RAX_" was not found!") Q
 .S RAITEM(RAX)=Y
 .Q
 ;
 I ($D(RAITEM)\10)=0 D  Q
 .D BMES^XPDUTL("Exiting: There are no '"_RAMENU_"' menu ITEMS to be removed.")
 .Q
 ;
 ; Remove the options, save as subscripts from the menu identifed
 ; by RAORDER.
 ;
 S (RAX,Y)=""
 F  S RAX=$O(RAITEM(RAX)) Q:RAX=""  D
 .S Y=$$DELETE^XPDMENU(RAMENU,RAX)
 .;Y = 1 success; else 0
 .S RATXT(1)="'"_RAX_"' was "_$S(Y=0:"not ",1:"")_"removed as an ITEM"
 .S RATXT(2)="under the '"_RAMENU_"' menu."
 .D BMES^XPDUTL(.RATXT)
 .Q
 K RATXT
 ; call ACHN (see comments below)
 D ACHN
 Q
 ;
 ;// subroutines //
FIND1(RAX) ;find the option IEN based on the option name
 ;Input: RAX = option name
 ;Return: IEN option name; else -1
 N RAERR,Y
 S Y=$$FIND1^DIC(19,,"X",RAX,"","","RAERR")
 Q $S(Y=0!($D(RAERR)):-1,1:Y)
 ;
ACHN ;remove the "ACHN" xref file: 75.1, fld: 5
 ; Pre-"ACHN" deletion defn
 ;^DD(75.1,5,1,0)="^.1^^-1"        ^DD(75.1,5,1,2,0)="75.1^ACHN^MUMPS"
 ;^DD(75.1,5,1,2,1)="D:$$ORVR^RAORDU()=2.5&((X=1)!(X=3)) CH^RADD2(DA,X)"
 ;^DD(75.1,5,1,2,2)="Q"            ^DD(75.1,5,1,2,3)="Do not delete."
 ;
 ; delete the REQUEST STATUS "ACHN" xref (xref #: 2)
 ; results are recorded in RARSLT
 ; errors, if any, are recorded in RAERR.
 ; - RADD2 has no IAs
 ; - there are no external calls to CH^RADD2
 ;   (vivian dot worldvista dot org)
 ; The CH tag is to be removed from RADD2.
 ;
 K RARSLT,RAERR D DELIX^DDMOD(75.1,5,2,"","RARSLT","RAERR")
 I $D(RAERR) D
 .D BMES^XPDUTL("Error when trying to delete the ""ACHN"" xref (75.1; 5).")
 .Q
 E  D
 .D BMES^XPDUTL("The ""ACHN"" xref (75.1; 5) was successfully deleted.")
 .D:$G(RARSLT("DDAUD"))=1 BMES^XPDUTL("""ACHN"" deletion was recorded in the DD AUDIT (#.6) file.")
 .;national no longer compiles input tempates or cross-references on this file.
 .Q
EXIT ;clean up
 K RARSLT,RAERR
 Q
 ;
