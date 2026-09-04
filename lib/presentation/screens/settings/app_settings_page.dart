import 'package:flutter/material.dart';

// TODO: Not implemented yet
class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  // final TextEditingController _urlController = TextEditingController();
  // final _selectedQuality = VideoQualities.audio;
  // bool _isLoading = false;
  // String? _errorMessage;
  //
  // final List<String> _qualities = ['1080p', '720p', '480p', 'audio'];

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Descargar Video'),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.history),
    //         onPressed: () {
    //           Navigator.pushNamed(context, '/history');
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Consumer<DownloadProvider>(
    //       builder: (context, provider, child) {
    //         return Column(
    //           children: [
    //             TextField(
    //               controller: _urlController,
    //               decoration: InputDecoration(
    //                 labelText: 'URL del Video',
    //                 border: const OutlineInputBorder(),
    //                 suffixIcon: IconButton(
    //                   icon: const Icon(Icons.clear),
    //                   onPressed: () => _urlController.clear(),
    //                 ),
    //               ),
    //               enabled: provider.activeTask == null,
    //             ),
    //             const SizedBox(height: 16),
    //
    //             // Error Message
    //             if (_errorMessage != null)
    //               Container(
    //                 padding: const EdgeInsets.all(12),
    //                 decoration: BoxDecoration(
    //                   color: Colors.red.shade50,
    //                   borderRadius: BorderRadius.circular(8),
    //                 ),
    //                 child: Text(
    //                   _errorMessage!,
    //                   style: const TextStyle(color: Colors.red),
    //                 ),
    //               ),
    //             const SizedBox(height: 16),
    //
    //             // Download Button
    //             if (provider.activeTask == null)
    //               ElevatedButton(
    //                 onPressed: _isLoading ? null : _startDownload,
    //                 child: _isLoading
    //                     ? const SizedBox(
    //                         height: 20,
    //                         width: 20,
    //                         child: const CircularProgressIndicator(
    //                           strokeWidth: 2,
    //                           valueColor: const AlwaysStoppedAnimation(
    //                             Colors.white,
    //                           ),
    //                         ),
    //                       )
    //                     : const Text('DESCARGAR'),
    //                 style: ElevatedButton.styleFrom(
    //                   padding: const EdgeInsets.symmetric(vertical: 16),
    //                 ),
    //               ),
    //
    //             // Active Download Progress
    //             if (provider.activeTask != null)
    //               Card(
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(16),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Text(
    //                         provider.activeTask!.videoTitle,
    //                         style: const TextStyle(
    //                           fontWeight: FontWeight.bold,
    //                           fontSize: 16,
    //                         ),
    //                         maxLines: 2,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                       const SizedBox(height: 8),
    //                       LinearProgressIndicator(
    //                         value: provider.activeTask!.progress,
    //                         backgroundColor: Colors.grey.shade200,
    //                       ),
    //                       const SizedBox(height: 8),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Text(
    //                             '${(provider.activeTask!.progress * 100).toStringAsFixed(1)}%',
    //                             style: const TextStyle(
    //                               fontWeight: FontWeight.bold,
    //                               color: Colors.blue,
    //                             ),
    //                           ),
    //                           Text(
    //                             provider.activeTask!.quality.quality,
    //                             style: const TextStyle(color: Colors.grey),
    //                           ),
    //                         ],
    //                       ),
    //                       const SizedBox(height: 8),
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             child: Text(
    //                               'Descargando...',
    //                               style: TextStyle(color: Colors.grey.shade600),
    //                             ),
    //                           ),
    //                           TextButton(
    //                             onPressed: () {
    //                               provider.cancelActiveDownload();
    //                             },
    //                             child: const Text(
    //                               'CANCELAR',
    //                               style: const TextStyle(color: Colors.red),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //
    //             // Recent Downloads
    //             if (provider.tasks.isNotEmpty)
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 16),
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const Text(
    //                       'Descargas recientes',
    //                       style: const TextStyle(
    //                         fontSize: 18,
    //                         fontWeight: FontWeight.bold,
    //                       ),
    //                     ),
    //                     const SizedBox(height: 8),
    //                     ...provider.tasks
    //                         .take(3)
    //                         .map(
    //                           (task) => ListTile(
    //                             leading: Icon(
    //                               _getStatusIcon(task.status),
    //                               color: _getStatusColor(task.status),
    //                             ),
    //                             title: Text(
    //                               task.videoTitle,
    //                               maxLines: 1,
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                             subtitle: Text(
    //                               '${task.quality} • ${_formatDate(task.createdAt)}',
    //                               style: const TextStyle(fontSize: 12),
    //                             ),
    //                             trailing:
    //                                 task.status == DownloadStatus.completed
    //                                 ? IconButton(
    //                                     icon: const Icon(Icons.folder_open),
    //                                     onPressed: () {
    //                                       // Abrir archivo
    //                                     },
    //                                   )
    //                                 : null,
    //                             onTap: () {
    //                               Navigator.pushNamed(context, '/history');
    //                             },
    //                           ),
    //                         )
    //                         .toList(),
    //                   ],
    //                 ),
    //               ),
    //           ],
    //         );
    //       },
    //     ),
    //   ),
    // );
  }

  // Future<void> _startDownload() async {
  //   if (_urlController.text.isEmpty) {
  //     setState(() => _errorMessage = 'Por favor ingresa una URL');
  //     return;
  //   }
  //
  //   setState(() {
  //     _isLoading = true;
  //     _errorMessage = null;
  //   });
  //
  //   try {
  //     final provider = Provider.of<DownloadProvider>(context, listen: false);
  //     await provider.startDownload(
  //       url: _urlController.text,
  //       quality: _selectedQuality,
  //     );
  //     _urlController.clear();
  //   } catch (e) {
  //     setState(() => _errorMessage = e.toString());
  //   } finally {
  //     setState(() => _isLoading = false);
  //   }
  // }
  //
  // IconData _getStatusIcon(DownloadStatus status) {
  //   switch (status) {
  //     case DownloadStatus.completed:
  //       return Icons.check_circle;
  //     case DownloadStatus.failed:
  //       return Icons.error;
  //     case DownloadStatus.downloading:
  //       return Icons.downloading;
  //     default:
  //       return Icons.pending;
  //   }
  // }
  //
  // Color _getStatusColor(DownloadStatus status) {
  //   switch (status) {
  //     case DownloadStatus.completed:
  //       return Colors.green;
  //     case DownloadStatus.failed:
  //       return Colors.red;
  //     case DownloadStatus.downloading:
  //       return Colors.blue;
  //     default:
  //       return Colors.orange;
  //   }
  // }
  //
  // String _formatDate(DateTime date) {
  //   final now = DateTime.now();
  //   final difference = now.difference(date);
  //
  //   if (difference.inDays == 0) {
  //     return 'Hoy';
  //   } else if (difference.inDays == 1) {
  //     return 'Ayer';
  //   } else if (difference.inDays < 7) {
  //     return 'Hace ${difference.inDays} días';
  //   } else {
  //     return '${date.day}/${date.month}/${date.year}';
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   _urlController.dispose();
  //   super.dispose();
  // }
}
