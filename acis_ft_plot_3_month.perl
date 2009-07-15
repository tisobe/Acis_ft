#/usr/bin/perl
use PGPLOT;

#################################################################################
#										#
#	plot_3_month.perl: plotting 3 month long fp temp			#
#		this is a part of a csh script: plotting_script			#
#	author: Takashi Isobe							#
#	March 14, 2005	first version						#
#										#
#	Last Update: Apr 5, 2006						#
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
$data_dir       = $dir_list[1];
$house_keeping  = $dir_list[2];
$short_term     = $dir_list[3];
$data_out       = $dir_list[4];
$web_dir        = $dir_list[5];

##############################################################################

@today = localtime(time);                       # find today's date
$day = $today[7];
$year = $today[5] + 1900;

$month_ago = $day - 90;                         # when was three month ago?
$mday      = $month_ago;
$year_mago = $year;
$this_year = $year;
if($month_ago < 1) {
	$lyear = $year -1;
	$chk   = 4 * int(0.25 * $lyear);
	if($lyear == $chk){
                $month_ago += 366;
                $year_mago--;
        }else{
                $month_ago += 365;
                $year_mago--;
        }
}


open(IN,"$data_out/month_data");
@time  = ();
@avg   = ();
@dev   = ();
$count = 0;
$sum   = 0;
while(<IN>) {
	chomp $_;
        @atemp = split(/\t/,$_);
        $year  = $atemp[0];
        $day   = $atemp[1];
        $avg   = $atemp[2];
        $add   = 0;
	if($year_mago < $this_year && $year == $this_year){
                $add   = 365; 
		$lyear = $year -1;
		$chk   = 4 * int(0.25 * $lyear);
		if($lyear == $chk){
                        $add++;
                }
        }

	$chk = 4.0 * int (0.25 * $year);
	if($chk == $year){
		$div = 366;
	}else{
		$div = 365;
	}

        if($year >= $year_mago && $day >= $month_ago){
#
#--- exclude over flow data
#
		unless( $avg > 1000 || $avg < -1000) {
			$date = $year + $day/$div;
			push(@time, $date);
			push(@avg, $avg);
			push(@dev, $dev);
			$sum = $sum + $avg;
			$count++;
		}
	}
}
close(IN);
#
#--- plot starts here
#
pgbegin(0, "/ps",1,1);
pgsubp(1,1);
pgsch(2);
pgslw(4);

$xmin = $time[0];
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
system("echo ''| /opt/local/bin/gs -sDEVICE=pgmraw -sOutputFile=- -g2100x2769 -r256x256 -q pgplot.ps| $bin_dir/pnmcrop| $bin_dir/pnmscale -xsize 500| $bin_dir/ppmquant 16| $bin_dir/pnmpad -white -l20 -r20 -t20 -b20| $bin_dir/pnmflip -r270| $bin_dir/ppmtogif > $web_dir/Figs/month3_plot.gif");

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
        pglabel("Time (Year)","Temp (C)", "ACIS Focal Plane Temperature (Three Month Plot)");
	pgclos();
}
