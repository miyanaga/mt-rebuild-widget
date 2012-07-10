use strict;
use warnings;

package MT::CMS::RebuildWidget;

sub on_template_param_rebuild_popup {
    my ( $cb, $app, $param, $tmpl ) = @_;

    $param->{html_head} ||= '';
    $param->{html_head} .= q{
        <style type="text/css">
            #brand { display: none; }
            body.chromeless-wide #container { min-width: inherit; margin: 10px; }
            .actions-bar button { display: inline-block; margin-bottom: 16px; }
            .actions-bar button.close { display: none; }
            body { height: 100%; }
        </style>
    };
}

sub on_template_param_edit_template {
    my ( $cb, $app, $param, $tmpl ) = @_;

    return unless $param->{blog_id};
    return unless $param->{saved};

    my $target = $tmpl->getElementById('badtag-list');
    my $el = $tmpl->createElement('app:widget', {
        id      => 'rebuild-widget',
        label   => '<__trans phrase="Publish Site">',
    });
    $el->innerHTML(<<'MTML');
    <iframe id="rebuild-widget-iframe" src="<$mt:CGIPath$><$mt:AdminScript$>?__mode=rebuild_confirm&amp;blog_id=<$mt:var name="blog_id"$>">
    </iframe>
    <style type="text/css">
        #rebuild-widget-iframe { border: none; max-width: 100%; min-height: 190px; }
        #rebuild-widget .widget-content { padding: 0px; }
    </style>
MTML

    $tmpl->insertAfter($el, $target);
}

1;
__END__
