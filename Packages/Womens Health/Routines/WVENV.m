WVENV ;HCIOFO/FT-Environment Check ;9/24/98  09:07
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;;
EN ; check if Rad/nm patch is installed.
 I '$$PATCH^XPDUTL("RA*5.0*2") D
 .S WVTEXT(1)="NOTE: The Radiology/Nuclear Medicine v5.0 package has an event"
 .S WVTEXT(2)="      point (included with RA*5.0*2) which will notify the Women's"
 .S WVTEXT(3)="      Health package whenever a radiology report is verified"
 .S WVTEXT(4)="      for a mammogram. This event point allows mammograms"
 .S WVTEXT(5)="      to be automatically entered into the Women's Health"
 .S WVTEXT(6)="      Procedure file (#790.1)."
 .S WVTEXT(7)=" "
 .S WVTEXT(8)="      To use this functionality install RA*5.0*2."
 .S WVTEXT(9)="      Please continue with this package installation."
 .D BMES^XPDUTL(.WVTEXT)
 .Q
 K WVTEXT
 Q
