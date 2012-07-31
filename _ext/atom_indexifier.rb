module Awestruct
  module Extensions
    class AtomIndexifier

      def execute(site)
        site.pages.each do |page|
          if ( page.inhibit_indexifier || ( page.output_path =~ /^(.*\/)?index.atom$/ ) )
            page.output_path = page.output_path.gsub( /index.atom$/, 'atom/index.html' )
          end
        end
      end

    end
  end
end