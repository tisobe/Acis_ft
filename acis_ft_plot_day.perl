#/usr/bin/perl
use PGPLOT;

#################################################################################
#										#
#	acis_ft_plot_day.perl: plotting routine for a day			#
#		this is a part of a csh script plotting_script			#
#	author: Takashi Isobe							#
#	March 14, 2000	first version						#
#										#
#	Last Update: Apr 6, 2006						#
#										#
#################################################################################
 
##############################################################################
#
#---- directory setting
#

open(FH, './dir_list');
@dir_list = ();
while(<FH>){
	chomp $_;
	push(@dir_list, $_);
}
close(FH);
$bin_dir        = $dir_list[0];
$data_dir	= $dir_list[1];
$house_keeping  = $dir_list[2];
$short_term     = $dir_list[3];
$data_out       = $dir_list[4];
$web_dir 	= $dir_list[5];

##############################################################################

@today = localtime(time);                       # find today's date
$wday  = $today[7] - 7;
$cday  = $today[7] - 1;
$year  = $today[5] + 1900;
$cyear = $year;
if($cday < 1) {
	$lyear = $year -1;
	$chk   = 4.0 * int (0.25 * $lyear);	# checking a leap year
	if($lyear == $chk){
                $cday += 366;
                $cyear--;
        }else{
                $cday += 365;
                $cyear--;
        }
}
#
#--- week_data has a most detail data
#
open(IN, "$data_out/week_data");
@time  = ();
@avg   = ();
@dev   = ();
$count = 0;
$sum   = 0;
while(<IN>) {	
	chomp $_;
	@atemp = split(/\t/,$_);
	$year = $atemp[0];
	$day  = $atemp[1];
	$avg  = $atemp[2];
        $add  = 0;
	if($year >= $cyear && $day >= $cday){
#
#---  remove over flow data
#
		unless( $avg > 1000 || $avg < -1000) {
			$add = 0;
			push(@time, $day);
			push(@avg, $avg);
			$sum = $sum + $avg;
			$count++;
		}
	}
}
close(IN);
#
#--- plotting starts here
#
pgbegin(0, "/ps",1,1);
pgsubp(1,1);		
pgsch(2);		
pgslw(4);

$xmin = $time[1];
$xmax = $time[$count-2];
$cent = $sum/$count;
@temp = sort{$a<=>$b} @avg;
@temp = reverse(@temp);
OUTER:
foreach $ent (@temp) {
	if($ent < -80) {
		$ymax = $ent+1;
		last OUTER;
	}
}
$ymin = $temp[$count-4]- 2;
#
#--- plotting sub
#
plot_fig();
#
#--- changing a ps-file to a gif-file
#
system("echo ''| gs -sDEVICE=pgmraw -sOutputFile=- -g2100x2769 -r256x256 -q pgplot.ps| $bin_dir/pnmcrop| $bin_dir/pnmscale -xsize 500| $bin_dir/ppmquant 16| $bin_dir/pnmpad -white -l20 -r20 -t20 -b20| $bin_dir/pnmflip -r270| $bin_dir/ppmtogif > $web_dir/Figs/day_plot.gif");

system("rm pgplot.ps");

##################################
### plot_fig: plotting routine ###
##################################

sub plot_fig {

        pgenv($xmin, $xmax, $ymin, $ymax, 0, 0);

        pgpt(1, $time[0], $avg[0], -1);                # plot a point (x, y)
        for($m = 1; $m < $count-1; $m++) {
                unless($avg[$m] eq '*****' || $avg[$m] eq ''){
                        pgpt(1,$time[$m], $avg[$m], -2);
                }
        }
        pglabel("Time (Day of Year)","Temp (C)", "ACIS Focal Plane Temperature (Day)"); 
	pgclos();
}
