//context.products = delegator.findList("Product", null, null, null, null, false);
context.products = delegator.findList("ProductCategoryMember", null, null, null, null, false);
context.categories = delegator.findList("ProductCategory", null, null, null, null, false);

server = request.getScheme()+"://"+request.getServerName();
if ( request.getServerPort() != 80 && request.getServerPort() != 443 ) {
    server = server + ":" + request.getServerPort();
}
context.urlBase = server;

// CHECKME:
// how can we know how many shops we handle, and what are their mount points?
context.mountPoints = new java.util.LinkedList();
context.mountPoints.add("/");
context.mountPoints.add("/shophr/");
context.mountPoints.add("/shopeu/");