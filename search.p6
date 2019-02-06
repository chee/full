#!/usr/bin/env perl6
sub MAIN ($term) {
	my @data = dir("./data").hyper.map({.slurp});

	my @counts = @data.hyper.map({
		.match(/ <|w><$term><|w> /, :g)
		.Int
	});

	my $document-frequency = [+] @counts.hyper.map({.Bool});

	my @scores = @counts.hyper.map({
		$_ * (1 / $document-frequency)
	});

	say 'no match' and exit 2 unless $document-frequency;

	say (@data Z @scores)
		.sort({.tail})
		.tail
		.head;
}
