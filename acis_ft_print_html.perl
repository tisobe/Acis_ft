#!/usr/bin/perl

#########################################################################################
#											#
#	acis_ft_print_html.perl: printing html pages					#
#											#
#	author: t. isobe (tisobe@cfa.harvard.edu)					#
#											#
#	Last Update: Apr. 05, 2006							#
#											#
#########################################################################################


#######################################################################################
#
#---- diretory setting
#
open(FH, './dir_list');
@dir_list = ();
while(<FH>){
        chomp $_;
        push(@dir_list, $_);
}
close(FH);
$bin_dir        = $dir_list[0];
$data_dir       = $dir_list[1];
$house_keeping  = $dir_list[2];
$short_term     = $dir_list[3];
$data_out       = $dir_list[4];
$web_dir        = $dir_list[5];

#######################################################################################

#
#--- find today's date
#
($usec, $umin, $uhour, $umday, $umon, $uyear, $uwday, $uyday, $uisdst)= localtime(time);

if($uyear < 1900) {
        $uyear = 1900 + $uyear;
}
$month = $umon + 1;
#$uyday++;

if ($uyear == 1999) {
        $dom = $uyday - 202 + 1;
}elsif($uyear >= 2000){
        $dom = $uyday + 163 + 1 + 365*($uyear - 2000);
#
#---- add an extra day after a leap year
#
	$add_date += int(0.25 * ($year - 1997));
	$dom += $add_date;
}
#
#--- the main focal plane temperature html page
#
open(OUT, ">$web_dir/main_fp_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF0000" background="./stars.jpg">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots</CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
$utoday = $uyday + 1;
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<br>',"\n";
print OUT '<p><font color=yellow>Note: Due to instrumental problems, the focal temperature values ';
print OUT 'taken between dates 2005:259.5 and 2005:289.5 are not reliable</font></p>',"\n";
print OUT '<br>',"\n";
print OUT '<TABLE BORDER=0 Cellspacing = 6 Cellpadding =10 Align=center>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH></TH><TH>Focal Plane Temp</TH><TH colspan=2>(Focal Plane Temp - Cold Radiator) </TH>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>Entire Mission</TH><TD Align=center><A HREF=./fp_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./entire_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./entire_side_b.html>Side B</A></TD>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT "<br><br>";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>Past 3 Months</TH><TD Align=center><A HREF=./fp_month3_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./month3_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./month3_side_b.html>Side B</A></TD>';
print OUT '</TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>Past Month</TH><TD Align=center><A HREF=./fp_month_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./month_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./month_side_b.html>Side B</A></TD>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>Past Week</TH><TD Align=center><A HREF=./fp_week_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./week_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./week_side_b.html>Side B</A></TD>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>Last 3 Days</TH><TD Align=center><A HREF=./fp_3day_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./day3_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./day3_side_b.html>Side B</A></TD>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '<TH>One Day</TH><TD Align=center><A HREF=./fp_day_temp.html>Temp Plot</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./today_side_a.html>Side A</A></TD>';
print OUT "\n";
print OUT '                     <TD Align=center><A HREF=./today_side_b.html>Side B</A></TD>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '<TR></TR>';
print OUT "\n";
print OUT '<TR>';
print OUT "\n";
print OUT '</TR>';
print OUT "\n";
print OUT '</TABLE>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<FONT SIZE=-1>';
print OUT "\n";
print OUT '<A HREF=./long_term_data>Long Term Data (Averaged)</A>';
print OUT "\n";
print OUT '(DOM:FP Temp:Side A:Side B)';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<A HREF=./month_data>Data for the Last 90 Days (about 5min avg)</A>';
print OUT "\n";
print OUT '(Year: DOY: FP Temp:Side A:Side B)';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<A HREF=./week_data>Data for the Last 10 days</A>';
print OUT "\n";
print OUT '(Year: DOY: FP Temp:Side A:Side B)';
print OUT "\n";

close(OUT);
#
#---- the entire range
#
open(OUT, ">$web_dir/fp_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots</CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/fp_temp.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- three months 
#
open(OUT, ">$web_dir/fp_month3_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots (Three Months) </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots (Three Months)</CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month3_plot.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- a month long
#
open(OUT, ">$web_dir/fp_month_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots (Month) </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots (Month)</CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month_plot.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- a week long
#
open(OUT, ">$web_dir/fp_week_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots (A Week) </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots (A Week) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/week_plot.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- three day long
#
open(OUT, ">$web_dir/fp_3day_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots (3 Days) </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots (3 Days) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/day3_plot.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- one day long
#
open(OUT, ">$web_dir/fp_day_temp.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Focal Plane Temperature Plots (Day) </title>';
print OUT "\n";
print OUT '<CENTER><H1>ACIS Focal Plane Temperature Plots (Day) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
print OUT "$uyear-$month-$umday  ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF YEAR: $utoday ";
print OUT "\n";
print OUT "<br>";
print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/day_plot.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);

############ diff temp entire period
#
#--- entire range side A
#
open(OUT, ">$web_dir/entire_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/entire_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- entire range side B
#
open(OUT, ">$web_dir/entire_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator B </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/entire_side_b.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);


############# diff temp three month
#
#---- 3 month side A
#
open(OUT, ">$web_dir/month3_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A (Three Months) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A (Three Months) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month3_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- 3 month side B
#
open(OUT, ">$web_dir/month3_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator B (Three Months) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B (Three Months)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month3_side_b.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);


############# diff temp a month
#
#--- a month long side A
#
open(OUT, ">$web_dir/month_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A (Month) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A (Month) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- a month long side B
#
open(OUT, ">$web_dir/month_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator B (Month) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B (Month)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/month_side_b.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);

##################### diff temp. a week
#
#--- a week long side A
#
open(OUT, ">$web_dir/week_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A (Week) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A (Week)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/week_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- a week long side B
#
open(OUT, ">$web_dir/week_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator B (Week) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B (Week)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/week_side_b.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);

########## diff temp. 3 days
#
#--- 3 day long side A
#
open(OUT, ">$web_dir/day3_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A (3 days) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A (3 days)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/day3_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- 3 day long, side B
#
open(OUT, ">$web_dir/day3_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B (3 days)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/day3_side_b.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);


################## diff temp one day
#
#--- one day, side A
#
open(OUT, ">$web_dir/today_side_a.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator A (Today) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator A (Today) </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/today_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);
#
#--- one day, side B
#
open(OUT, ">$web_dir/today_side_b.html");

print OUT '<HTML>';

print OUT '<BODY TEXT="#FFFFFF" BGCOLOR="#000000" LINK="#00CCFF" VLINK="#B6FFFF" ALINK="#FF00
00">';
print OUT "\n";
print OUT '<title> ACIS Difference bewtween FP Temp and Cold Radiator B (Today) </title>';
print OUT "\n";
print OUT '<CENTER><H1> ACIS Difference bewtween FP Temp and Cold Radiator B (Today)  </CENTER>';
print OUT "\n";
print OUT '<CENTER><H1>Updated ';
#print OUT "$uyear-$month-$umday  ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF YEAR: $utoday ";
#print OUT "\n";
#print OUT "<br>";
#print OUT "DAY OF MISSION: $dom ";
print OUT '</H1></CENTER>';
print OUT "\n";
print OUT '<P>';
print OUT "\n";
print OUT '<HR>';
print OUT "\n";
print OUT '<IMG SRC="./Figs/today_side_a.gif">';
print OUT "\n";
print OUT '</CENTER>';
print OUT "\n";
print OUT '';
print OUT "\n";
close(OUT);

