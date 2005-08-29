package Catalyst::Plugin::DefaultEnd;

use base qw/Catalyst::Base/;

our $VERSION='0.01';

=item NAME

Catalyst::Plugin::DefaultEnd - Sensible default end action.

=item SYNOPSIS

    use Catalyst qw/-Debug DefaultEnd/;

=item DESCRIPTION

This action implements a sensible default end action, which will forward
to the first available view, unless status is set to 3xx, or there is a
response body. It also allows you to pass dump_info=1 to the url in order
to force a debug screen, while in debug mode.

If you have more than 1 view, you can specify which one to use with the
'view' config setting.

=head1 METHODS

=over 4

=item end

The default end action, you can override this as required in your application
class, normal inheritance applies.

=cut

sub end : Private {
    my ( $self, $c ) = @_;
    die "forced debug" if $c->debug && $c->req->params->{dump_info};
    return 1 if $c->response->status =~ /^3\d\d$/;
    return 1 if $c->response->body;                         
    unless ( $c->response->content_type ) {
       $c->response->content_type('text/html; charset=utf-8');
    }
    return $c->forward($c->config->{view}) if $c->config->{view};
    my ($comp) = $c->comp('^'.ref($c).'::(V|View)::');
    $c->forward(ref $comp);
}


1;
