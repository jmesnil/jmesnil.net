require 'patched_atomizer'
require 'atom_indexifier'
require 'posts_archiver'

Awestruct::Extensions::Pipeline.new do
  extension Awestruct::Extensions::Posts.new '/weblog'
  extension Awestruct::Extensions::Paginator.new :posts, '/weblog/index', :per_page => 20
  extension Awestruct::Extensions::PostsArchiver.new '/weblog/archive', :posts, :archive
  extension Awestruct::Extensions::Indexifier.new

  extension Awestruct::Extensions::PatchedAtomizer.new :posts, '/weblog/feed/index.atom', :feed_title=>"Jeff Mesnil" 
  extension Awestruct::Extensions::AtomIndexifier.new

  extension Awestruct::Extensions::Sitemap.new

  helper Awestruct::Extensions::Partial
  helper Awestruct::Extensions::GoogleAnalytics
end

