#!/usr/bin/perl

#########################################################################################
#											#
#	acis_ft_make_list.perl: this perl script prepare data for plotting		#
#	this is a part of csh script plotting_script.					#
#											#
#	author: Takashi Isobe	(tisobe@cfa.harvard.edu)				#
#	first version: 3/14/00								#
#	last update: Apr 06, 2006							#
#											#
#	You must set environment to: 							#
#		setenv ACISTOOLSDIR /home/pgf						#
#	before running this scripts (pgf scripts: getnrt and fptemp.pl)			#
#											#
#########################################################################################

#########################################################
#
#---- directory setting
#
$bin_dir 	= '/data/mta/MTA/bin/';
$data_dir	= '/data/mta/MTA/data/';
$web_dir	= '/data/mta/www/mta_fp/';
$house_keeping	= '/data/mta/www/mta_fp/house_keeping/';
$data_out	= '/data/mta/www/mta_fp/Data/';
$short_term	= '/data/mta/Script/Focal/Short_term/';

#$bin_dir 	= '/data/mta/Script/Focal/Develop/Focal/';
#$data_dir	= '/data/mta/MTA/data/';
#$house_keeping	= '/data/mta/Script/Focal/Develop/house_keeping/';
#$short_term	= '/data/mta/Script/Focal/Develop/Short_term/';
#$data_out	= '/data/mta/Script/Focal/Develop/Data/';
#$web_dir	= '/data/mta/Script/Focal/Develop/web_dir/';

open(OUT, ">./dir_list");
print OUT "$bin_dir\n";
print OUT "$data_dir\n";
print OUT "$house_keeping\n";
print OUT "$short_term\n";
print OUT "$data_out\n";
print OUT "$web_dir\n";
close(OUT);

#########################################################
#
#--- old_list_short contains a list of data previously read into the data
#
open(FH,"$house_keeping/old_list_short");
@old_list_short = ();			
while(<FH>) {
        chomp $_;
        @atemp = split(/\/dsops\/GOT\//, $_);
#
#--- first find the date that the file is created.
#
        @btemp = split(/\s+/, $atemp[0]);

        $lm    = $btemp[4];
        $cday  = $btemp[5];
        $ctime = $btemp[6];

        if($lm eq "Jan") {
                $cmonth = 1;
        }elsif($lm eq "Feb"){
                $cmonth = 2;
        }elsif($lm eq "Mar"){
                $cmonth = 3;
        }elsif($lm eq "Apr"){
                $cmonth = 4;
        }elsif($lm eq "May"){
                $cmonth = 5;
        }elsif($lm eq "Jun"){
                $cmonth = 6;
        }elsif($lm eq "Jul"){
                $cmonth = 7;
        }elsif($lm eq "Aug"){
                $cmonth = 8;
        }elsif($lm eq "Sep"){
                $cmonth = 9;
        }elsif($lm eq "Oct"){
                $cmonth = 10;
        }elsif($lm eq "Nov"){
                $cmonth = 11;
        }elsif($lm eq "Dec"){
                $cmonth = 12;
        }
        @dtemp = split(/_/,  $atemp[1]);
	@etemp = split(/\//, $dtemp[0]);
	if($etemp[0] eq 'input'){
		$cyear = $etemp[1];
	}else{
        	$cyear = $dtemp[0];
	}
#
#--- data list without the file information 
#--- (remove: -rw-r--r--   1 got      59420898 Mar  2 09:54
#---  and keep: /dsops/GOT/input/2006_088_2228_089_0409_Dump_EM_30564.gz)
#
        $dat_name = '/dsops/GOT/'."$atemp[1]";
	push(@old_list_short, $dat_name);
}
close(FH);

@old_list_short = sort(@old_list_short);		#	sorting 

#
#--- create a list from /dsops/GOT/input (for a new list)
#
system("ls -ldtr  /dsops/GOT/input/*Dump_EM* > zztemp");

open(FH,"./zztemp");
@new_list     = ();
@new_save     = ();
@new_list_org = ();

while(<FH>) {
        chomp $_;
	$org_line = $_;
        @atemp = split(/\/dsops\/GOT\/input\//, $_);
        @btemp = split(/ /, $atemp[0]);
        @ctemp = ();
        foreach $word (@btemp) {
                if($word =~ /\w/){
                        push(@ctemp, $word);
                }
        }
        $time = $ctemp[6];
        $day  = $ctemp[5];
        $lm   = $ctemp[4];
        if($lm eq "Jan") {
                $month = 1;
        }elsif($lm eq "Feb"){
                $month = 2;
        }elsif($lm eq "Mar"){
                $month = 3;
        }elsif($lm eq "Apr"){
                $month = 4;
        }elsif($lm eq "May"){
                $month = 5;
        }elsif($lm eq "Jun"){
                $month = 6;
        }elsif($lm eq "Jul"){
                $month = 7;
        }elsif($lm eq "Aug"){
                $month = 8;
        }elsif($lm eq "Sep"){
                $month = 9;
        }elsif($lm eq "Oct"){
                $month = 10;
        }elsif($lm eq "Nov"){
                $month = 11;
        }elsif($lm eq "Dec"){
                $month = 12;
        }

        @dtemp = split(/_/, $atemp[1]);
        $year  = $dtemp[0];

        $dat_name = '/dsops/GOT/input/'."$atemp[1]";
	@ftemp    = split(/_Dump_EM/, $atemp[1]);
#
#--- here we are comparing date of file creating. if there are
#
	if($year > $cyear) {
		push(@new_save,     $ftemp[0]);
		push(@new_list,     $dat_name);
		push(@new_list_org, $org_line);
#
#--- any file created after the last entry of the old list the data 
#--- name will be added in a new_list.
#
	}elsif($year == $cyear){
		if($month > $cmonth) {
			push(@new_save,     $ftemp[0]);
			push(@new_list,     $dat_name);
			push(@new_list_org, $org_line);
		}elsif($month == $cmonth){
			if($day > $cday) {
				push(@new_save,     $ftemp[0]);
				push(@new_list,     $dat_name);
				push(@new_list_org, $org_line);
			}elsif($day == $cday) {
				if($time > $ctime){
					push(@new_save,     $ftemp[0]);
					push(@new_list,     $dat_name);
					push(@new_list_org, $org_line);
				}
			}
		}
	}
}
close(FH);
#
#--- sort accroding to file name
#
@new_list = sort(@new_list);
system("rm zztemp");		
#
#--- today's date
#
@time  = localtime(time);
$cyear = $time[5] + 1900;
$add   = 365*($cyear - 2000);

$m_ch = 0;
$w_ch = 0;
$s_ch = 0;

$year_day = 365;
$lyear = $cyear -1;
$chk   = 4 * int(0.25 * $lyear);
if($lyear == $chk){
	$year_day = 366;
}

#
#--- date of a month ago
#
$m_ago   = $time[7] - 30;
if($m_ago < 0){
        $m_ch = $year_day + $m_ago;
}
#
#--- date of a week ago
#
$w_ago    = $time[7] - 7 ;
if($w_ago < 0) {
        $w_ch = $year_day + $w_ago;
}
#
#--- date of 3 days ago
#
$d3ago  = $time[7] - 3 ;
if($d3ago < 0) {
        $s_ch = $year_day + $d3ago;
}

$today = $time[7];

open(OUT," >> $house_keeping/old_list_short");

foreach $ent (@new_list_org) {
	print OUT "$ent\n";
}
close(OUT);
#
#---- update old_list_short
#
open(OUT,">./today_list");
foreach $ent (@new_list){
	push(@old_list_short, $ent);
	print OUT "$ent\n";
#
#--- following is Peter Ford (pgf@space.mit.edu) script to extract data from dump data
#
	@stmp1 = split(/_Dump_EM/, $ent);
	@stmp2 = split(/\/dsops\/GOT\/input\//,$stmp1[0]);
	system("/opt/local/bin/gzip -dc $ent |$bin_data/Acis_ft/getnrt -O $* | $bin_dir/acis_ft_fptemp.pl >> $short_term/data_$stmp2[1]");
}
close(OUT);
#
#--- month data
#
@m_list  = ();
@w_list  = ();
@d3_list = ();
foreach $ent (@old_list_short) {
	@atemp = split(/_/,$ent);
	@btemp = split(/input\//, $atemp[0]);
	if($m_ch == 0) {
		if($btemp[1] >= $cyear && $atemp[1] >= $m_ago) {
			push(@m_list, $ent);	# m_list: month data list
		}
	}else{
		if($btemp[1] >= $lyear && $atemp[1] > $m_ch) {
			push(@m_list, $ent);
		}elsif($atemp[1] > 0 && $atemp[1] <= $today) {
			push(@m_list, $ent);
		}
	}
#
#--- week data
#
	if($lday == 0) {
		if($btemp[1] >= $cyear && $atemp[1] >= $w_ago) {
			push(@w_list, $ent);	# w_list: week data list
		}
	}else{
		if($btemp[1] >= $lyear && $atemp[1] > $w_ch) {
			push(@w_list, $ent);
		}elsif($atemp[1] > 0 && $atemp[1] <= $today) {
			push(@w_list, $ent);
		}
	}
#
#--- 3 day data
#
	if($lday == 0) {
		if($btemp[1] >= $cyear && $atemp[1] >= $d3ago) {
			push(@d3_list, $ent);	# d3_list: 3 day data list
		}
	}else{
		if($btemp[1] >= $lyear && $atemp[1] > $s_ch) {
			push(@d3_list, $ent);
		}elsif($atemp[1] > 0 && $atemp[1] <= $today) {
			push(@d3_list, $ent);
		}
	}
}

#
#--- in this block, try to figure out  which files are with in a day
#

@t_list = reverse (@old_list_short);
$last   = shift(@t_list);		
@btemp  = split(/_/,$last);
$cyear  = $btemp[0];
$cday   = $btemp[3];
@btemp  = split(//, $btemp[4]);
$chr    = "$btemp[0]"."$btemp[1]";
$cmin   = "$btemp[2]"."$btemp[3]";

push(@d_list, $last);

OUTER:
foreach $ent(@t_list) {
	@ctemp = split(/_/,$ent);
	$year  = $ctemp[0];
	$day   = $ctemp[3];
	@ctemp = split(//,$ctemp[4]);
	$hr    = "$ctemp[0]"."$ctemp[1]";
	$min   = "$ctemp[2]"."$ctemp[3]";
	$dyear = $cyear - $year;
	$dday  = $cday - $day;
	$dhr   = $chr -$hr;
	$dmin  = $cmin -$min;
	$diff  = $dyear * 525600 + $dday * 1440 + $dhr * 60 + dmin;

	if($diff < 1440) {
		push(@d_list, $ent);		# d_list: day data list
	}else {
		last OUTER;
	}
}

@d_list = reverse(@d_list);

#
#--- create a temporary file for a month
#
open(OUT,">./month_list");
foreach $data (@m_list){
	@atemp = split(/\//,$data);
	if($atemp[3] eq 'input') {
		$ztemp = $atemp[4];
	}else{
		$ztemp = $atemp[3];
	}
	@btemp = split(/_Dump_EM_/,$ztemp);
	$dname = 'data_'."$btemp[0]";
	print OUT "$dname\n";
}
close(OUT);

#
#--- create a temporary file for a week
#
open(OUT,">./week_list");
foreach $data (@w_list){
	@atemp = split(/\//,$data);
	if($atemp[3] eq 'input') {
		$ztemp = $atemp[4];
	}else{
		$ztemp = $atemp[3];
	}
	@btemp = split(/_Dump_EM_/,$ztemp);
	$dname = 'data_'."$btemp[0]";
	print OUT "$dname\n";
}
close(OUT);
#
#--- create a temporary file for 3 days
#
open(OUT,">./day3_list");
foreach $data (@d3_list){
	@atemp = split(/\//,$data);
	if($atemp[3] eq 'input') {
		$ztemp = $atemp[4];
	}else{
		$ztemp = $atemp[3];
	}
	@btemp = split(/_Dump_EM_/,$ztemp);
	$dname = 'data_'."$btemp[0]";
	print OUT "$dname\n";
}
close(OUT);
#
#--- create a temporary file for a day
#
open(OUT,">./day_list");
foreach $data(@d_list){
	@atemp = split(/\//,$data);
	if($atemp[3] eq 'input') {
		$ztemp = $atemp[4];
	}else{
		$ztemp = $atemp[3];
	}
	@btemp = split(/_Dump_EM_/,$ztemp);
	$dname = 'data_'."$btemp[0]";
	print OUT "$dname\n";
}
close(OUT);

open(OUT, ">./new_list");
foreach $ent (@new_save){
	print OUT "$ent\n";
}
close(OUT);
