var App = App || {};
App.Presenters = App.Presenters || {};

App.Presenters.PostContentPresenter = function(
	util,
	promise,
	presenterManager,
	postNotesPresenter) {

	var post;
	var templates = {};
	var $target;

	function init(params, loaded) {
		$target = params.$target;
		post = params.post;

		promise.wait(util.promiseTemplate('post-content'))
			.then(function(postContentTemplate) {
				templates.postContent = postContentTemplate;
				render();
				loaded();
			}).fail(function() {
				console.log(arguments);
				loaded();
			});
	}

	function render() {
		$target.html(templates.postContent({post: post}));

		if (post.contentType === 'image') {
			loadPostNotes();
		}
	}

	function loadPostNotes() {
		presenterManager.initPresenters([
			[postNotesPresenter, {post: post, notes: post.notes, $target: $target.find('.post-notes-target')}]],
			function() {});
	}

	return {
		init: init,
		render: render,
	};

};

App.DI.register('postContentPresenter', [
	'util',
	'promise',
	'presenterManager',
	'postNotesPresenter'],
	App.Presenters.PostContentPresenter);
