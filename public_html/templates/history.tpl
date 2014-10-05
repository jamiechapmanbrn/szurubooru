<h1>History</h1>
<table class="history">
	<tbody>
		<% _.each(history, function( historyEntry) { %>
			<tr>
				<td class="time">
					<%= formatRelativeTime(historyEntry.time) %>
				</td>

				<td class="user">
					<% var userName = historyEntry.user && historyEntry.user.name || '' %>

					<% if (userName) { %>
						<a href="#/user/<%= userName %>">
					<% } %>

					<img width="20" height="20" class="author-avatar"
						src="/data/thumbnails/20x20/avatars/<%= userName || '!' %>"
						alt="<%= userName || 'Anonymous user' %>"/>

					<%= userName || 'Anonymous user' %>

					<% if (userName) { %>
						</a>
					<% } %>
				</td>

				<td class="subject">
					<% if (historyEntry.type == 0) { %>
						<a href="#/post/<%= historyEntry.primaryKey %>">
							@<%= historyEntry.primaryKey %>
						</a>
					<% } else { %>
						?
					<% } %>
				</td>

				<td class="difference">
					<% if (historyEntry.operation == 1) { %>
						deleted
					<% } else { %>
						changed

						<% if (historyEntry.dataDifference) { %>
							<ul><!--
								--><% _.each(historyEntry.dataDifference['+'], function (difference) { %><!--
									--><li class="addition difference-<%= difference[0] %>"><!--
										--><%= difference[0] + ':' + difference[1] %><!--
									--></li><!--
								--><% }) %><!--

								--><% _.each(historyEntry.dataDifference['-'], function (difference) { %><!--
									--><li class="removal difference-<%= difference[0] %>"><!--
										--><%= difference[0] + ':' + difference[1] %><!--
									--></li><!--
								--><% }) %><!--
							--></ul>
						<% } %>
					<% } %>
				</td>
			</tr>
		<% }) %>
	</tbody>
</table>
